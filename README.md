# efuhair. A light version of a Salon management systems showcasing the efuzy framework ( MUMPS and Vue)

Demo => [https://www.youtube.com/watch?v=BdRVduf7Ylk](https://www.youtube.com/watch?v=BdRVduf7Ylk). Comments on the video would be appreaciated :)


## Installation Steps:
> ### MUMPS

>> #### 1) => Import the routines found in the routines folder.
>> #### 2) => Run the Salon routine to setup the routing table (^MI(":WS","ROUTES"))
 ```
 YDB>D ^SALON
 ```
>> #### 3 => Start the web server(web server listens on port 7777) (Vue expects port 7777) ^MI(":WS","PORT") 
```
YDB>D Start^MIWS
MI Web Server started.
```
>> ##### To stop the Web server run:
```
YDB>D Stop^MIWS
```

> ### Vue
>> #### 1 => Install the dependencies (if npm gives you trouble, delete the package-lock.json and try again)
```bash
npm install
```
>> #### 2 => Start the app in development mode (hot-code reloading, error reporting, etc.) [ it take a while to compile due to the size of the app]
```bash
quasar dev
```
>> ##### To Lint the files
```bash
npm run lint
```
>> ##### To Build the app for production
```bash
quasar build
```

> ### Running the app
>> #### 1=> Navigate to http://localhost:7001/app/ (it should launch automattically)
>> #### 2=> Click on Signup to register a new Salon
>> #### 3=> Fill Out the Profile Name, Email, Password, and choose (I'm signing up as a salon). The profile name will be the name of the global uppercase. Each Salon's data is stored under one global.
>> #### 4=> Click on Submit, and login to the app ( choose the Salon icon )
>> #### 5=> Populate the following tables necessary for the Calendar to work by navigating to:
>> ##### 1) Clients => Add new clients, then add a new client. I suggest uploading sample pics when adding data to each table
>> ##### 2) Staff => Add Staff ( this will populate the calendar resources)
>> ##### 3) Services
>> ##### 4) Categories
>> ##### 5) Locations
>> ##### 6) Customiztions => Status Colors, and add a Template name with the name "booked" (needed for the appointment status)
>> ##### 7) Naviagate to the Calendar and start adding appointments



> ### Notes
>> #### This app was originally written for Cache and was later ported to YottaDB. it's not 100% ported, so expect some errors here and there
>> #### This app was 100% SMS based, so alot of feature will not work locally for obvious reasons. Just enough to get the concept across
>> #### Since this was written for cache, The -KEY_SIZE, and -RECORD_SIZE need to be expanded in GDE. Here is my Template
```

                                *** TEMPLATES ***
                                                                          Std      Inst
                                             Def      Rec   Key Null      Null     Freeze Qdb   Epoch              LOCK
 Region                                     Coll     Size  Size Subs      Coll Jnl on Err Rndwn Taper AutoDB Stats Crit
 ----------------------------------------------------------------------------------------------------------------------
 <default>                                     0     4080   255 NEVER     Y    Y   N      N     Y     N      Y     Sep
                  Jnl File (def ext: .mjl)  Before  Buff      Alloc      Exten   AutoSwitch
 ------------------------------------------------------------------------------------------
 <default>        <based on DB file-spec>   Y       2312       2048       2048      8386560


 Segment          Active              Acc Typ Block      Alloc Exten Options
 ------------------------------------------------------------------------------
 <default>          *                 BG  DYN  4096       5000 10000 GLOB =1000
                                                                     LOCK =  40
                                                                     RES  =   0
                                                                     ENCR = OFF
                                                                     MSLT =1024
                                                                     DALL = YES
                                                                     AIO  = OFF
 <default>                            MM  DYN  4096       5000 10000 DEFER
                                                                     LOCK =  40
                                                                     MSLT =1024
                                                                     DALL = YES

         *** NAMES ***
 Global                             Region
 ------------------------------------------------------------------------------
 *                                  DEFAULT

                                *** REGIONS ***
                                                                                               Std      Inst
                                 Dynamic                          Def      Rec   Key Null      Null     Freeze Qdb   Epoch           
   LOCK
 Region                          Segment                         Coll     Size  Size Subs      Coll Jnl on Err Rndwn Taper AutoDB Sta
ts                                                                                                                                   
   Crit
 ------------------------------------------------------------------------------------------------------------------------------------
-------
 DEFAULT                         DEFAULT                            0  1048576  1019 NEVER     Y    Y   N      N     Y     N      Y  
   Sep

                          *** JOURNALING INFORMATION ***
 Region                          Jnl File (def ext: .mjl)  Before Buff      Alloc      Exten   AutoSwitch
 --------------------------------------------------------------------------------------------------------
 DEFAULT                         $ydb_dir/$ydb_rel/g/yottadb.mjl
                                                           Y      2312       2048       2048      8386560


                                *** SEGMENTS ***
 Segment                         File (def ext: .dat)Acc Typ Block      Alloc Exten Options
 -------------------------------------------------------------------------------------------
 DEFAULT                         $ydb_dir/$ydb_rel/g/yottadb.dat
                                                     BG  DYN  4096       5000 10000 GLOB=1000
                                                                                    LOCK=  40
                                                                                    RES =   0
                                                                                    ENCR= OFF
                                                                                    MSLT=1024
                                                                                    DALL= YES
                                                                                    AIO = OFF

                                  *** MAP ***
   -  -  -  -  -  -  -  -  -  - Names -  -  - -  -  -  -  -  -  -
 From                            Up to                            Region / Segment / File(def ext: .dat)
 --------------------------------------------------------------------------------------------------------------------------
 %                               ...                              REG = DEFAULT
                                                                  SEG = DEFAULT
                                                                  FILE = $ydb_dir/$ydb_rel/g/yottadb.dat
 LOCAL LOCKS                                                      REG = DEFAULT
                                                                  SEG = DEFAULT
                                                                  FILE = $ydb_dir/$ydb_rel/g/yottadb.dat

```


> ### Debugging the app
>> #### Globals ^MI("OUT") and ^MI("IN") hold all data sent back and forth. ( these should be cleared for production)
>> #### Global ^MI("ZERR") holds unhandeled errors sequentionally. I suggest running D ^AA to view the global
>> #### Chrome Dev Tools should show all communications between Vue and MUMPS

