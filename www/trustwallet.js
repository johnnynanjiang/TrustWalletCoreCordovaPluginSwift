window.createWallet = function(name, password, callback) {
  cordova.exec(callback, function(err) {
      callback(err);
  }, "TrustWallet", "createWallet", [name, password]);
};

window.exportMnemonic = function(walletId, password, callback) {
  cordova.exec(callback, function(err) {
      callback(err);
  }, "TrustWallet", "exportMnemonic", [walletId, password]);
};

