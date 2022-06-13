const axios = require('axios').default;
module.exports = {
       afterCreate: async (event) => {
        const { result, params } = event;
        var res = await axios.post('https://us-central1-workspacer-c329e.cloudfunctions.net/createUser', {
          "email": result.login,
          "passwd": result.password,
          "isAdmin": true,
          "strapiId": result.id
      })
      },
  };