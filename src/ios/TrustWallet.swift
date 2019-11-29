import Foundation
import TrustWalletCore

@objc(TrustWallet)
public class TrustWallet : CDVPlugin {
  @objc
  func createWallet(_ command: CDVInvokedUrlCommand) {
    let echo = command.argument(at: 0) as! String?
    let pluginResult:CDVPluginResult

   //Hdw wallet stuff
   let Hdw = TrustWalletCore.HDWallet(strength: 128, passphrase: "password")
    let privkey = Hdw.getKeyForCoin(coin: TrustWalletCore.CoinType.bitcoin)
    let pubkey = privkey.getPublicKeyCurve25519()
    let pubkeydesc = pubkey.description
    print("HD wallet mmenonic: ", Hdw.mnemonic )
    print("HD wallet public key: ", pubkeydesc )
    
    //keystore
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    let docURL = URL(string: documentsDirectory)!
    let dataPath = docURL.appendingPathComponent("Wallets")
    
    do {
    let keystore = try TrustWalletCore.KeyStore(keyDirectory: dataPath)
    }
     catch {
        print("Unexpected error: \(error).")
    }
    
    if echo != nil && echo!.count > 0 {
        pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: echo!)
    } else {
        pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR)
    }

    self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
  }
}
