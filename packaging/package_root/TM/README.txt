Kaltura On-Prem  V6 - Release Notes
***********************************

General
=======
Kaltura On-Prem V6.0 is based on the Falcon release of the Kaltura online video platform.
It provides new features, infrastructure enhancements, and new API services.

Supported/Tested OS
====================
Kaltura On-Prem has been tested on the following operating systems:
- Ubunto 10.04 - 32-bit/64-bit 
- RHEL5/6/ CentOS 6.2  – 32-bit/64-bit
Please note that it is possible to install Kaltura On-Prem on other Linux distributions as well, however it was not yet fully tested by Kaltura

New Features and Functionalities
================================
The following list includes the main new features that are available as part of the Kaltura On-Prem V6.0,
 for more information, please refer to the KMC Quick Start Guide: 
- Full support for PHP 5.3.x
- Full Support of any VAST ad server in player (Player Advertising tab in KMC studio)
- Custom Metadata Fields
- Mobile support (trascoding flavors)
- Net Storage - enabling auto-export to and delivery from a remote storage.
- Sphinx - full text search engine (bundled within the Kaltura CE package)- All entries and playlists searches moved to sphinx search engine
- Server-side Plug-in infrastructure 
		
Features that require additional setup/3rd party licensing/CDN capabilities
===========================================================================
- RTMP delivery – requires FMS/CDN integration
- Adaptive bit-rate – requires FMS/CDN integration (already integrated with Akamai)
- Analytics – for capturing CDN bandwidth usage – CDN logs integration is needed (already integrated with CDN logs of Akamai, limelight, level3)
- Analytics – user geo-distribution analytics – requires ip2location DB license or integration with another ip to geo service
- Live streaming workflow – requires CDN integration for live channel provisioning (already integrated with Akamai live channel provisioning).
- Webcam recording – requires FMS integration 
- Access control – geo restriction - requires ip2location DB license for maintainable ip2location DB (current mapping relies on the IP to country database from http://software77.net/geo-ip
- Advertising – requires 3rd party account at target ad server
- Content syndication via Tubemogul – requires a tubemogul account
- Transcoding to the VP6 codec requires On2 transcoder – configuration instructions to be provided.

Known Issues
============
- Kaltura On-Prem should run as a Virtual Host under Apache2
- The links within the KMC 'Quick Start Guide' PDF are pointing to the KMC hosted by Kaltura at www.kaltura.com and not to the local Kaltura On-Prem
-----------------------------------------------------------------------------------------------------------------