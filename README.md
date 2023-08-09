
# Fast Download (FastDL) Setup and Comparison Guide

**Introduction:**
- This document aims to provide a comprehensive understanding of the Fast Download (FastDL) system, its operation, potential issues, and a comparison with alternative content distribution methods, specifically Workshop Download (WorkshopDL) and Server Download (ServerDL). Whether you're an experienced server administrator or new to the Garry's Mod scene, this guide will equip you with essential knowledge for optimizing content delivery to clients.

**Overview:**
- FastDL is a content distribution system that utilizes the HTTP protocol to efficiently deliver resources to clients externally via your dedicated web host. This method ensures flexibility and speed, making it a preferred choice for many server administrators. This guide addresses the workings of FastDL, any potential complications, and compares it to WorkshopDL and ServerDL to highlight its advantages.

**Setting Up FastDL for Garry's Mod:**
- Setting up FastDL for Garry's Mod can be complex due to limited resources available on its configuration and operation. To facilitate this process, this guide provides step-by-step instructions and insightful tips for a seamless experience. It is important to note that FastDL content is structured differently from the typical Garry's Mod addon structure.

**Comparison: WorkshopDL vs. ServerDL vs. FastDL:**
 - Understanding the differences between these content distribution methods is crucial for optimizing your server's performance and player experience. Here, we present a comprehensive comparison of WorkshopDL, ServerDL, and FastDL, highlighting their distinct features, advantages, and limitations. This information aids in making an informed decision on the most suitable distribution method for your specific server needs.

**ServerDL:**
- ServerDL, the default content distribution method, involves direct content downloads from the server. While it's efficient for smaller content sizes, its default download speed is capped at 20 kilobits per second (20kbps). This guide delves into the setup process and limitations of ServerDL, helping you understand when and how to utilize it effectively.

**WorkshopDL:**
- WorkshopDL, commonly paired with a workshop collection, utilizes Valve's CDN to distribute content. This method relies on players' subscriptions to the content pack or individual addons, and its setup involves defining the content through Lua scripts. However, WorkshopDL's download speed is typically slower than FastDL, often falling below the 20kbps threshold. This guide offers a comprehensive walkthrough of WorkshopDL configuration, shedding light on its potential advantages and drawbacks.

**FastDL:**
- FastDL stands out as the optimal solution for efficient content distribution. By utilizing your own web host, FastDL overcomes download speed limitations associated with other methods. The guide provides a detailed overview of FastDL's benefits, its compatibility with compressed files in the Bzip2 format, and how it maximizes loading speed by significantly reducing file sizes. Additionally, it offers practical advice on setting up and managing FastDL to ensure seamless content delivery.

**Challenges and Solutions:**
- Alongside the benefits of FastDL, this guide outlines potential challenges you might encounter. Bandwidth costs and the risk of unauthorized content usage are addressed, along with viable solutions to mitigate these issues. By understanding these challenges, you'll be better equipped to manage them effectively.

**Optimizing Content Structure:**
- One unique aspect of FastDL is its file structure. Unlike Garry's Mod's conventional addon layout, FastDL requires specific organization. This guide provides a clear breakdown of the required file structure for FastDL, enabling efficient content delivery and ensuring that your players experience minimal loading times.

**Conclusion:**
- In conclusion, FastDL offers an advanced and efficient solution for content distribution in Garry's Mod servers. Its flexibility, speed, and optimization capabilities make it a preferred choice for server administrators aiming to enhance player experience. By following the guidelines and insights provided in this comprehensive documentation, you'll be well-equipped to set up, manage, and troubleshoot FastDL effectively. Should any questions arise during the process, our support team is readily available to assist you.


## Installation and Configuration


**Step 1:** Setting Up the Web Server

**Choose a Linux Distribution:**
- Start by selecting a Linux distribution to host your web server. Popular choices include Ubuntu or Debian. 

- You can use one of the hosting described in this repository [awesome-free-hosters](https://github.com/manohvh/awesome-free-hosters) for a free Ubuntu VPS

**Install Apache Web Server (Ubuntu):**
Use the following commands to install Apache on Ubuntu:
```bash
sudo apt update
sudo apt install apache2
```
**Configure the Document Root:**
Your web server's document root is where FastDL files will be stored. By default, it's usually located at `/var/www/html/`.

**Set Permissions:**
Ensure proper permissions for the document root folder so that you can upload files:

Create User
```
sudo adduser YOUR_USERNAME
```
Set Permissions for your User
```
sudo chown -R YOUR_USERNAME:YOUR_USERNAME /var/www/html/
sudo chmod -R 755 /var/www/html/
```
**Step 2:** Setting Up FTP for Web Server

Install vsftpd (Very Secure FTP Daemon):
Install vsftpd using the following command:


```
sudo apt install vsftpd
```
**Configure vsftpd:**
in my opinion it's better when you use this [tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-20-04) for set up a ftp for your user, make shure you change that section to: 
```
. . .
local_root=/var/www/html/
```
and for make shure make restart again runing that command:
```
sudo systemctl restart vsftpd
```
**Step 3:** Uploading Garry's Mod Files

Organize Addon Folders:
Ensure your addons are organized with the following folders: `models/, materials/, sounds/, resource/, and lua/`.


It should look something like this:
```
ADDON_Name/
-> lua/
-> materials/
-> sounds/
-> resource/
-> models/
```

**Use the Provided Script:**
Utilize the provided script from the GitHub repository to automate the process of copying the necessary folders. Adjust the script according to your server's settings.

bz2converter.bat - (!Only for windows) convert entire folder to .bz2 file

fileconvertertobz2.bat - (!Only for windows) convert all files in folder and subfolders to .bz2 

filelenameprint.bat - (!Only for windows) printing to file forma `addresource.("file path")` 

you can read what is .bz2 file and why im using it in other `.md` file in this repository

**Step 4:** Configuring FastDL in Garry's Mod Server

Edit server.cfg:
Navigate to your Garry's Mod folder and find `garrysmod/cfg/server.cfg`. If the line sv_downloadurl does not exist, add it with your web server's URL:

```
sv_downloadurl "http://yourwebserverhere/"
```
Configure Content to Download:
Use a Lua script to define what clients will download. Create a file named fastdl.lua in `garrysmod/lua/autorun/server/.`

Example script:

```
if (SERVER) then
  -- EXAMPLE
  resource.AddFile("maps/gm_construct.bsp") -- Uncompressed
  -- resource.AddFile("maps/gm_construct.bsp.bz2") -- Compressed ( smaller filesize )
end
```
Conclusion:
By following these steps, you'll successfully set up FastDL for your Garry's Mod server. This comprehensive configuration allows efficient content delivery and ensures a smooth experience for players joining your server. Remember to adapt the provided scripts and commands to match your server's specifics.
    
