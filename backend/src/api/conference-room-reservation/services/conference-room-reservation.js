'use strict';

/**
 * conference-room-reservation service.
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::conference-room-reservation.conference-room-reservation');
