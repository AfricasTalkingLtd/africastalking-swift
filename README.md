# Africa's Talking

This SDK simplifies the integration of Africa's Talking APIs into your iOS apps. For better security,
the SDK is split into two components: A **server** module that stores API keys, SIP credentials and other secrets.
And a **client** module that runs in your app. This client module gets secrets from the server component (via RPC), and uses them to interact with the various APIs.

For instance, to send an SMS, the client with request a token from the server; The server will use it's API key to request a token from Africa's Talking on behalf of the client. It will then forward the token to the client which will use it to request the SMS API to send a text. All in a split second!


### Usage

Your server application could be something like this:

```Js
/* On The Server (Java, Node.js, PHP, C/C++, C# and all languages supported by gRPC.) */

const options = {
    apiKey: 'YOUR_API_KEY',         // Use sandbox API key for sandbox development
    username: 'YOUR_USERNAME',      // Use "sandbox" for sandbox development
};
const Server = require('africastalking/server');
const srv = new Server(options);
srv.start({
    privateKeyFile: fs.readFileSync('path/to/pk'),
    certChainFile: fs.readFileSync('path/to/cert/chain'),
    rootCertFile: fs.readFileSync('path/to/root/cert'),
    port: 35897,
    insecure: false,
});
```

And your iOS app:

```swift
/* On The Client (iOS) */

// Init SDK
AfricasTalking.initialize(SERVER_HOSTNAME)

// Get Service
let airtime = AfricasTalking.getAirtimeService()

// Use Service
let recipients = [
  ["phoneNumber": "+254718769882", "currencyCode": "KES", "amount": 332],
  ["phoneNumber": "0718769881", "currencyCode": "KES", "amount": 324 ]
]
airtime.send(to: recipients) {error, data in
  //...
}
```

See the [example](./example) for complete sample apps (iOS, Node)

### Download

#### Server

**Node**

```shell
npm install --save africastalking
```

**Java**

```groovy
repositories {
  maven {
    url  "http://dl.bintray.com/africastalking/java"
  }
}
dependencies{
  compile 'com.africastalking:server:VERSION'
}
```

Or Maven (from `http://dl.bintray.com/africastalking/java`)

```xml
<dependency>
  <groupId>com.africastalking</groupId>
  <artifactId>server</artifactId>
  <version>VERSION</version>
</dependency>
```


#### Client (iOS)
With Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourApp"
    //...
    dependencies: [
        .package(url: "https://github.com/AfricastalkingLtd/africastalking-swift.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: ["AfricasTalking",]
        )
    ]
    //...
)
```


## Initialization
The following static methods are available in the `africasTalking` package to initialize the library:

- `initialize(host: String, port: Int, disableTls: Bool)`: Initialize the library.
- `getXXXService()`: Get an instance to a given `XXX` service. e.g. `.getSmsService()`, `.getPaymentService()`, etc.


## Services

All methods take a `Africastalking.Callback: (error: String?, data: JSON?) -> Void` as the last parameter.

### `Account`
- `getUser()`: Get user information.

### `Airtime`

- `send(to: String, amount: String)`: Send airtime to a phone number. Amount with currency code, e.g. `USD 10`

- `send(recipients: [[String: Any]])`: Send airtime to a bunch of phone numbers. The keys in the `recipients` map are phone numbers while the values are airtime amounts ( e.g. `KES 678`).

For more information about status notification, please read [http://docs.africastalking.com/airtime/callback](http://docs.africastalking.com/airtime/callback)

### `Token`

- `createCheckoutToken(phoneNumber: String)`: Create a checkout token.

### `SMS` **TODO**

- `send(message: String, recipients: [String])`: Send a message

- `sendBulk(message: String, recipients: [String])`: Send a message in bulk

- `sendPremium(message: String, keyword: String, linkId: String, recipients: [String])`: Send a premium SMS

- `fetchMessage()`: Fetch your messages

- `fetchSubscription(shortCode: String, keyword: String)`: Fetch your premium subscription data

- `createSubscription(shortCode: String, keyword: String, phoneNumber: String)`: Create a premium subscription

For more information on: 

- How to receive SMS: [http://docs.africastalking.com/sms/callback](http://docs.africastalking.com/sms/callback)

- How to get notified of delivery reports: [http://docs.africastalking.com/sms/deliveryreports](http://docs.africastalking.com/sms/deliveryreports)

- How to listen for subscription notifications: [http://docs.africastalking.com/subscriptions/callback](http://docs.africastalking.com/subscriptions/callback)

### `Payment` **TODO**

- `checkout(request: CheckoutRequest)`: Initiate checkout(mobile, card or bank).

- `validateCheckout(request: CheckoutValidateRequest)`: Validate checkout (card or bank).

- `payConsumers(productName: String, recipients: [Consumer])`: Send money to consumer. 

- `payBusiness(productName: String, recipient: Business)`: Send money to business.

### Voice


- `makeCall(from: String, to: [String])`: Initiate an outbound call `from` your virtual number `to` some number(s)

- `queueStatus(phoneNumbers: String)`: Query call queue status

- `mediaUpload(url: String, phoneNumber: String)`: Upload media file



## Credit  

For more info, please visit [https://www.africastalking.com](https://www.africastalking.com)