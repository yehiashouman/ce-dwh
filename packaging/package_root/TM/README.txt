Kaltura On-Prem  V5 - Release Notes
***********************************
General
=======
Kaltura On-Prem V5.0 is based on the Eagle release of the Kaltura online video platform.  It provides  new features, infrastructure enhancements, and new API services.

Supported/Tested OS
====================
Kaltura On-Prem has been tested on the CentOS 6.2/64bit operating system. 

While it is possible to install Kaltura CE on other Linux distributions and on a 32-bit server, these configurations were not tested by Kaltura.


New Features and Functionalities
================================
The following list includes the main new features and infrastructure changes that are available as part of the release. For more information, please refer to the packaged KMC Guide or to the Kaltura CE documentation pages within kaltura.org or the “what’s new in Eagle” document at http://blog.kaltura.org/wp-content/uploads/2011/09/Kaltura-Eagle-Release-Whats-New.pdf

- New Upload Tab – upload and prepare media entries directly from the main KMC menu regardless of what page you’re working on. 
- Upload Control – manage and control your uploads, set priorities, track progress, and continue working in the KMC while your uploads continue processing in the background. 
- In Video Search – use Kaltura’s new “In Video Search” API to search for a specific phrase within a library of videos and find the exact point in the video where the phrase appears. 
- Multi Lingual Captions - upload caption files directly into the KMC in different languages and formats. Allow users to select their preferred language and caption setting.
- Clipping and Trimming – create clips from existing videos, set in and out points – each clip becomes its own media entry encoded to multiple flavors, and can be downloaded, distributed and played back on any device. You can also simply trim the length of a video – all directly from within the KMC.
- Advertising – insert cue-point and add mid-roll and overlay ads in any video.
- Metadata Improvements and Related Files – manage multiple metadata schemas and append related documents to media entries.
- Advanced Ingestion Capabilities –
- Control the order of ingestion, create “Draft Entries” with metadata and attach the video later
- Use your own transcoders, and ingest the output flavors to Kaltura
- Host videos at your preferred location and link to Kaltura
- Automate content ingestion using Drop Folders
- Seamlessly replace video assets for a Kaltura entry, media is replaced in all live and syndicated players



		
Features that require additional setup/3rd party licensing/CDN capabilities
============================================================================
Certain Functionality offered in conjunction with the Kaltura CE Video Cluster Software requires integration with 3rd party software or hardware. The table below includes information about such additional functionality, and the possible needed customization to customer’s need.

- Akamai HD Network& Apple HTTP Streaming - requires content delivery through Akamai - Akamai CDN account

- Analytics – for capturing CDN bandwidth usage- CDN logs integration is needed (already integrated with CDN logs of Akamai, limelight, level3) - requires CDN account

- RTMP delivery or adaptive bit rate delivery - requires CDN/FMS integration                                                   

- User geo-distribution analytics and/or access - requires ip2location DB license control

- Side by side Video and PowerPoint - Ability to show a dual head display for (example) interactive lectures where the viewer can skip between slides and the video will seek to the correct spot automatically. Custom work including setting up A server incl. license and addition of required conversion flavors - Microsoft 2008 server (See appendix: Microsoft document server requirements)

- Webcam recorder widget - Allows users to record webcam, and add metadata. Requires integration with the customers FMS (for example FMS/Adobe/Wowza/Red5) - If FMS – must be FMS Interactive server v3.5 only 

- HTTPS encryption for Login - Requires the creation of an HTTPS certificate by the customer and an Integration efforts - Can either install certificates on the load balancer or install directly on the servers.  

- SSO Integration - Integration with an external authentication server, to enable external user management and access to already logged in users - Prerequisite: details of the authentication server. 

- RTMP from FMS - Just for delivering video on demand. For Red5/Wowza/FMS Dependent on a discovery effort.

- In Video search - Be able to search across all videos in your system using Kaltura API and indexing of video captions - Requires designing and coding a search page.

- Live Streaming - Live streaming using a different media server than the included Akamai - Akamai – configuration only
Wowza or any other CDN– requires a specific integration project.

- Localization of KMC - A translation of all KMC strings, providing a localized experience for the Kaltura management console - Requires a translator to go over all emails and KMC texts. Providing Kaltura with the translated content.

- Custom player skins - Customize the look, feel and functionality of the Kaltura player - Requires graphic design which can be provided by Kaltura.



Known Issues
============

Q1290 - Switching to full screen mode while displaying an overlay ad can cause the overlay ad, in certain conditions, to disappear. 

Q1291 - Switching to full screen while displaying a post-roll or a mid-roll overlay ad causes the ad to visibly float to the correct position, instead of immediately reappearing in the correct position. 	

Q1293 - baseEntry->add “type” parameters is deprecated in the API:
In the API, the baseEntry->add type parameter is now deprecated and will be ignored. This is due to a change of behavior causing the type of the entry to be defined using the parameter “entry_type”. 

Q1294 - Different behaviors for auto-moderation, depending on which API is used: 
When a partner is set with "auto moderation" and a new playlist is added:
1. If the playlist is added through "baseEntry->add" API action - it will be auto moderated.
2. If the playlist is added through "playlist->add" API action - it will NOT be auto moderated.

Q1311 - Pausing, then resizing the player does not immediately resize the captions: 
When playing video with captions, clicking pause and changing the screen mode does not trigger a captions resize according to the new screen size.
When pressing Play, the captions are correctly resized.

