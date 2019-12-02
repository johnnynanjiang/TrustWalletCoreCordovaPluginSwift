import Foundation
import TrustWalletCore

@objc(TrustWallet)
public class TrustWallet : CDVPlugin {
    @objc
    func createWallet(_ command: CDVInvokedUrlCommand) {
        let name = command.argument(at: 0) as! String?
        let password = command.argument(at: 1) as! String?
        let pluginResult:CDVPluginResult
        
        //file path for keystore
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("TrustWallet")
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
        
        if name != nil && name!.count > 0 && password != nil && password!.count > 0 {
            do {
                //initialize keystore
                let keystore = try TrustWalletCore.KeyStore(keyDirectory: dataPath)
                //create wallet
                let wallet = try keystore.createWallet(name: name!, password: password!, coins: [TrustWalletCore.CoinType.bitcoin])
                let msg = "Wallet created: " + wallet.identifier
                print(wallet.identifier)
                pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: msg) } catch {
                    pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
            }
        } else {
            pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR)
        }
        
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc
    func exportMnemonic(_ command: CDVInvokedUrlCommand) {
        let walletId = command.argument(at: 0) as! String?
        let password = command.argument(at: 1) as! String?
        let pluginResult:CDVPluginResult
        
        if password != nil {
            
            do {
                //get path for keystore
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let documentsDirectory = paths[0]
                let docURL = URL(string: documentsDirectory)!
                let dataPath = docURL.appendingPathComponent("TrustWallet")
                
                //load keystore
                let keystore = try TrustWalletCore.KeyStore(keyDirectory: dataPath)
                
                //find wallet
                if let wallet = keystore.wallets.first(where: {$0.identifier == walletId}) {
                    
                    //get and return mnemonic
                    let mmenonic = try keystore.exportMnemonic(wallet: wallet, password: password!)
                    pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: mmenonic)
                    
                    
                } else {
                    pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: "No wallet found")
                }
                
            }
            catch {
                pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
            }
            
        } else {
            pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR)
        }
        
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
}


