# docker-qgis-ubuntu
QGIS graphical user interface running on Ubuntu.  Tailored for macOS.  

This repo allows QGIS users on macOS to access the latest QGIS on Ubuntu.  A good use case is that QGIS for Ubuntu has the Geospatial PDF workflow as part of the layout manager (a feature added in GDAL 3.x, that as of this writing is not a part of the QGIS for macOS).

###  How to build

```
docker build -t roblabs/qgis:ubuntu .
```

### Usage notes

```
docker run -p 6080:80 -p 5901:5900 -e VNC_PASSWORD=1234 -e RESOLUTION=2048x1152 -v $(pwd):/data roblabs/qgis:ubuntu
```

* `-p`   Map port 6080 to port 80
  * Make use of this by running this command to open in a web browser
  * `open http://localhost:6080`
* `-p`   Map port 5901 to port 5900
  * Make use of this by running this command to open in macOS Screen Sharing
  * `open vnc://localhost:5901`
* `-e VNC_PASSWORD`, is set as required by macOS Screen Sharing
* `-e RESOLUTION` can be adjusted, examples:
  * `1920x1080`
  * `2048x1152`   # for a Retina 4K monitor
* `-v $(pwd)`
  * local directory where `docker run` is issued, $(pwd), maps to `/data` on ubuntu

---

![docker-qgis-ubuntu](https://user-images.githubusercontent.com/118112/89135028-0e3e9780-d4df-11ea-860e-e3b41c59e38f.png)
