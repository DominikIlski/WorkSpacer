require("dotenv").config();
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { default: fetch } = require("node-fetch");



admin.initializeApp();
const auth = admin.auth();
exports.proxy = functions.https.onCall((data, context) => {
  const method = data.method;
  const body = data.body ? { data: data.body } : null;
  const route = data.route;

  return fetch(`https://work-spacer.herokuapp.com/api/${route}?populate=deep`, {
    method: method,
    ...(body && { body: JSON.stringify(body) }),
    headers: {
      Authorization: `Bearer ${process.env.API_KEY}`,
      ...(body && { "Content-Type": "application/json" }),
    },
  }).then((res) => res.json());
});

function addHours(numOfHours, date) {
  console.log(date);
  const newDate = new Date(date);
  newDate.setTime(date.getTime() + numOfHours * 60 * 60 * 1000);
  return newDate;
}

function dateRangeOverlaps(a_start, a_end, b_start, b_end) {
  if (a_start < b_start && b_start < a_end) return true; // b starts in a
  if (a_start < b_end && b_end < a_end) return true; // b ends in a
  if (b_start < a_start && a_end < b_end) return true; // a in b
  return false;
}

exports.notifyUser = functions.https.onCall((data, context) => {
  const isDesk = data.isDesk;
  const reservationId = data.reservationId;
  const available = [];
  return new Promise(async (resolve, reject) => {
    const workspaceData = await fetch(
      `https://work-spacer.herokuapp.com/api/${
        isDesk ? "desks" : "conference-room"
      }?populate=deep`,
      {
        method: "GET",
        headers: {
          Authorization: `Bearer ${process.env.API_KEY}`,
          "Content-Type": "application/json",
        },
      }
    ).then((res) => res.json());
    const allWorkspaces = workspaceData.data.map((e) => ({
      id: e.id,
      ...e.attributes,
    }));

    const reservationData = await fetch(
      `https://work-spacer.herokuapp.com/api/${
        isDesk ? "desk-reservations" : "cr-reservations"
      }/${reservationId}?populate=deep`,
      {
        method: "GET",
        headers: {
          Authorization: `Bearer ${process.env.API_KEY}`,
          "Content-Type": "application/json",
        },
      }
    ).then((res) => res.json());
    const reservation = {
      id: reservationData.data.id,
      ...reservationData.data.attributes,
    };
    const employeeId = reservation.idEmployee.data.id;
    const startDate = new Date(reservation.startDate);
    const endDate = addHours(reservation.duration, startDate);

    const res1 = await fetch(
      `https://work-spacer.herokuapp.com/api/${
        isDesk ? "desk-reservations" : "cr-reservations"
      }?populate=deep`,
      {
        method: "GET",
        headers: {
          Authorization: `Bearer ${process.env.API_KEY}`,
          "Content-Type": "application/json",
        },
      }
    ).then((res) => res.json());

    const reservations = res1.data
      .map((e) => ({ id: e.id, ...e.attributes }))
      .filter((e) =>
        isDesk ? !e?.idDeskCancellation?.data : !e?.idCRCancellation?.data
      );

    allWorkspaces.forEach((w) => {
      const worspaceReservations = reservations.filter((r) =>
        isDesk
          ? r?.idDesk?.data?.id === w.id
          : r?.idConferenceRoom?.data?.id === w.id
      );
      console.log("worksaceRes", worspaceReservations);
      let isOverlaping = false;
      worspaceReservations.forEach((wr) => {
        console.log(wr.startDate);
        const sd = new Date(wr.startDate);
        const ed = addHours(wr.duration, sd);
        console.log(1, sd);
        console.log(1, ed);
        console.log(2, startDate);
        console.log(2, endDate);
        if (dateRangeOverlaps(startDate, endDate, sd, ed)) {
          isOverlaping = true;
        }
      });
      if (!isOverlaping) {
        available.push(w);
      }
    });

    const notification = await fetch(
      `https://work-spacer.herokuapp.com/api/notifications`,
      {
        method: "POST",
        body: JSON.stringify({
          data: {
            isNew: true,
            employee: employeeId,
            cr_reservation: isDesk ? null : reservation.id,
            desk_reservation: isDesk ? reservation.id : null,
            desks: available.map((e) => e.id),
          },
        }),
        headers: {
          Authorization: `Bearer ${process.env.API_KEY}`,
          "Content-Type": "application/json",
        },
      }

    ).then((res) => res.json()); 
    console.log(notification);
    if(notification?.data?.id){
      resolve({ result: true });
    }
    else {
      resolve({reject: false})
    }
  });
});

exports.isDateAvailable = functions.https.onCall((data, context) => {
  const isDesk = data.isDesk;
  const startDate = addHours(2, new Date(data.date));
  const workspaceId = data.deskId;
  console.log(typeof startDate);
  const duration = data.duration;
  const endDate = addHours(duration, startDate);

  return new Promise(async (resolve, reject) => {
    const res = await fetch(
      `https://work-spacer.herokuapp.com/api/${
        isDesk ? "desk-reservations" : "cr-reservations"
      }?populate=deep`,
      {
        method: "GET",
        headers: {
          Authorization: `Bearer ${process.env.API_KEY}`,
          "Content-Type": "application/json",
        },
      }
    ).then((res) => res.json());
    let isOverlaping = false;

    const reservations = res.data
      .map((e) => ({ id: e.id, ...e.attributes }))
      .filter((e) =>
        isDesk ? !e?.idDeskCancellation?.data : !e?.idCRCancellation?.data
      ).filter((e) => isDesk ? e?.idDesk?.data?.id === workspaceId : e?.idConferenceRoom?.data?.id === workspaceId);
    for (let i = 0; i < reservations.length && !isOverlaping; i++) {
      const e = reservations[i];
      const sd = new Date(e.startDate);
      const ed = addHours(e.duration, sd);
      console.log(1, sd);
      console.log(1, ed);
      console.log(2, startDate);
      console.log(2, endDate);
      console.log(dateRangeOverlaps(startDate, endDate, sd, ed));
      if (dateRangeOverlaps(startDate, endDate, sd, ed)) {
        isOverlaping = true;
      }
    }
    console.log(isOverlaping);
    resolve({ msg: isOverlaping });
  });
});

exports.createUser = functions.https.onRequest((req, res) => {
  functions.logger.log(req);
  const body = req.body;
  const email = body.email;
  const passwd = body.passwd;
  const isAdmin = body?.isAdmin;
  const strapiId = body.strapiId;
  const name = body?.name;
  return auth
    .createUser({
      email: email,
      emailVerified: true,
      password: passwd,
      displayName: name ?? email.split("@")[0],
      disabled: false,
    })
    .then(function (userRecord) {
      auth.setCustomUserClaims(userRecord.uid, {
        admin: isAdmin,
        strapiId: strapiId,
      });
      res.status(200).send("user created");
      return "done";
    })
    .catch(function (error) {
      functions.logger.log("Error creating new user:", error);
      res.status(500).send(error);
    });
});
