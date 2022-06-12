
module.exports = {
       afterCreate: async (event) => {
        const { result, params } = event;
        console.log('whaaaaaaat')
        console.log(result);
        console.log(params)
      },
  };