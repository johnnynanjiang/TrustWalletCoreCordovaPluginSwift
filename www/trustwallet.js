window.createWallet = function(str, callback) {
  cordova.exec(callback, function(err) {
      callback('Error creating wallet');
  }, "TrustWallet", "createWallet", [str]);
};
