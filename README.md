# JSON-Parsing-using-swiftyJSON
Simple JSON Parsing using swiftyJSON into TableView . Also see for cardView in swift .

## **NOTE**

This project doesnot make use of storyBoard .  

If you are using a storyboard , follow the following steps -  

Step 1 - Create the usual view controller , embed in navigation bar and join it to the swift File ( a.k.a the usual steps).   
Step 2 - [Install Podfile](#Install_Podfile) .   
Step 3 - [Make allow http urls](#allow_http) (if your URL is not https) .   
Step 4 - Copy the Content , refractor the class Names and enjoy . 

## **<a name="Install_Podfile"></a>Install Podfile** 

Step 1 - Open terminal .   
Step 2 - Update your gem file with command . 
```Bash
  sudo gem install -n /usr/local/bin cocoapods
```
Step 3 - Give your project path . 
```Bash
  cd/your project path
```
Step 4 - Touch the Podifle
```Bash
  touch podfile
```
Step 5 - Open your podfile
```Bash
  open -e podfile
```
Step 6 - It will open a podfile like a text edit. Then set your target. For example if you want to set up **swifty JSON** then your podfile should be like . 
```Bash
  use_frameworks!
target 'yourProjectName' do
    pod 'SwiftyJSON', '~> 4.0'
end
```
Step 7 - Then install the pod
```bash
  pod install
```

** PS ** pod install may take some time so hang on .   

## **<a name="allow_http"></a>Allow http URLS** 
Step 1 - Right click on info.plist file and select open As -> Source Code  .   
Step 2 - Copy and Paste the following code .

``` XML
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    <key>NSExceptionDomains</key>
    <dict>
        <key>example.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSIncludesSubdomains</key>
            <true/>
        </dict>
    </dict>
</dict>
```



