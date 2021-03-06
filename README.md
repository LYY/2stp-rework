# 2STP Rework

2STP is a handy 2-step verification tool, but it had [stoped support](http://www.thomasrzhao.com/2stp-support/end-of-support/) because of the developer hired by Apple. I want to use it, so I decided to start learning iOS develop and make a new one.

## Milestone

All 2STP features:

* [ ] List all website and its account with 2-step code
  * [ ] search 2stp: website name and account name
  * [ ] colored line
  * [ ] refresh code every 30s
  * [ ] remove a 2-step item
  * [ ] drag to sort items
* [ ] scan a new website
  * [ ] display refresh animation
  * [ ] scan from 2-step QR code
  * [ ] add from 2-step secret key
* [ ] export accounts
  * [ ] export to an encrypted archive
    * [ ] export all
    * [ ] export selected accounts
  * [ ] export to QR code image
* [ ] import accounts
  * [ ] import from file
* [ ] settings
  * [ ] sync
    * [ ] iCloud Sync
    * [ ] Access Codes on Your Mac
  * [ ] security
    * [ ] Passcode & Touch ID
  * [ ] options
    * [ ] Code grouping style
      * None: 123456
      * Space: 123 456
      * Colon: 123:456
      * Bullet: 123·456
      * Hyphen: 123-456
    * [ ] Animate when codes update
    * [ ] Vibrate when code update
    * [ ] Time indicator changes color
  * [ ] support
    * [ ] website
  * [ ] reset
    * [ ] reset all data
* [ ] edit a account
  * [ ] display info
    * [ ] issuer
    * [ ] account name
    * [ ] accent color
  * [ ] key info
    * [ ] show hiddened secret code
    * [ ] share secret code
    * [ ] Advanced
      * type:
        * Time-based(TOTP)
        * Counter-based(HOTP)
      * Algorithm:
        * SHA1
        * SHA256
        * SHA512
        * MD5
      * Number of digits
  * [ ] preview

## Specification

### Export Accounts feature

The file generated by the Export Accounts feature is an encrypted archive.

Specifically, the account data is first archived with NSKeyedArchiver with a binary output format. Then, the resulting archived data is fed into [RNCryptor](https://github.com/RNCryptor/RNCryptor) along with the user-provided passcode.

More details of the precise format and instructions on how to decode it can be found [here](./references/OTPToken.swift).
