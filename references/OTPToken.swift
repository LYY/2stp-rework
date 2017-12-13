/**
    How to decode .2stp files
    ===

    .2stp files are created by using RNCryptor (file format v3) to encrypt the output from an NSKeyedArchiver using a binary output format, whose root object is an array of OTPToken objects.

    To decode .2stp files, first use RNCryptor to decrypt the file contents:

    ```
    let data = try RNCryptor.decrypt(data: fileData, withPassword: <password>)
    ```

    Then, use an NSKeyedUnarchiver to unarchive the array of OTPToken objects:

    ```
    let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
    unarchiver.requiresSecureCoding = true
    let tokens = unarchiver.decodeObject(of: [NSData.self, NSString.self, NSArray.self, NSNumber.self], key: NSKeyedArchiveRootObjectKey) as! [OTPToken]
    unarchiver.finishDecoding()
    ```

    The structure of the OTPToken class is described below.

    If a value is optional, it may not exist within the archived data. Check with aDecoder.containsValue before attempting to decode.

    "key" indicates the key to pass to the decoder.
    "encodes" indicates the class of the object stored in the archive. Pass this class to the decoder.

    For example, to decode the value for the secret, use the following code snippet:

    ```
    let secret = aDecoder.decodeObject(of: NSData.self, forKey: "secret") as! Data
    ```

    numDigits and period may be encoded within the archive as either NSNumber objects, or directly as NSIntegers, depending on the version of 2STP used to make the archive. To correctly handle this, make sure to first try decoding as an NSNumber, which will fail by returning nil if it is not present. If it does not decode as an NSNumber, then try decoding as an NSInteger.

    ```
    let numDigits = aDecoder.decodeObject(of: NSNumber.self, forKey: "numDigits") as? Int ?? aDecoder.decodeInteger(forKey: "numDigits")
    ```
*/
public class OTPToken: NSObject, NSSecureCoding {
    //required
    //key: "secret"
    //encodes: NSData
    //The shared secret
    public var secret: Data

    //optional
    //key: "issuer"
    //encodes: NSString
    //The name of the issuer
    public var issuer: String?

    //optional
    //key: "accountName"
    //encodes: NSString
    //The account name
    public var accountName: String?

    //required
    //key: "numDigits"
    //encodes: NSNumber OR NSInteger (see note)
    //The number of digits to display
    public var numDigits: Int

    //required
    //key: "algorithm"
    //encodes: NSString
    //values: one of "SHA1", "SHA256", "SHA512", "MD5"
    //The algorithm to use
    public var algorithm: String

    //optional
    //key: "uniqueID"
    //encodes: NSString
    //A UUID that uniquely identifies this particular token. Can be ignored
    public let uniqueID: String?

    //required
    //key: "type"
    //encodes: NSString
    //values: one of "totp", "hotp"
    //Whether to use time-based or counter-based code generation
    public var type: String

    //required iff type is "totp"
    //key: "period"
    //encodes: NSNumber OR NSInteger (see note)
    //The period, if time-based code generation is used
    public var period: Int?

    //required iff type is "hotp"
    //key: "counter"
    //encodes: NSNumber (use uint64Value property to retrieve value)
    //The counter, if counter-based code generation is used
    public var counter: UInt64?

    //optional
    //key: "accentColor"
    //encodes: NSString
    //values: A color represented in hex notation (no leading #)
    public var accentColor: String?

    public class var supportsSecureCoding : Bool {
        return true
    }
}


