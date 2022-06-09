'use strict';

/**
 * conference-room service.
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::conference-room.conference-room');
