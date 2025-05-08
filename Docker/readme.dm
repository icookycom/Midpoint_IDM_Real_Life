http://localhost:8080/midpoint/<br>
Username: administrator<br>
Password: Test5ecr3t<br>
<br>
ATTENTION: Script ninja.sh provided by Midpoint developers for import/export does not work now propertly, it does not import systemconfig settings like objectCollectionView.
So on Midpoint first start do:<br> 
1. In Admin GUI go to CONFIGURATION/System/Admin GUI Configuration/Edit raw<br>
And add befor<br>
&lt;/objectCollectionViews&gt;<br>
code from this file<br>
<a href ="https://github.com/icookycom/IDM-Midpoint-POC-Employments-and-Positions/blob/main/Docker/add_after_run_midpoint_objectcollectionviews.xml">./add_after_run_midpoint_objectcollectionviews.xml</a><br>
2. In Admin GUI go to CONFIGURATION/System/Sistem Configuration/Edit raw<br>
And add after<br>
&lt;internals&gt;<br>
code from this file<br>
<a href ="https://github.com/icookycom/IDM-Midpoint-POC-Employments-and-Positions/blob/main/Docker/add_after_run_midpoint_normalsearch.xml">./add_after_run_midpoint_normalsearch.xml</a><br>
In Admin GUI go to CONFIGURATION/About and press Reindex repository objects<br>

<br>
<br>
<b>Docker Compose</b><br>
For the Docker Compose, the Docker environment is required and Internet connection on first run.<br>
<br>
<b>Linux</b><br>
Copy folder Docker_POCE_Midpoint_491<br>
To start<br>
./Docker_POCE_Midpoint_491/docker compose up -d<br>
To turn off<br>
./Docker_POCE_Midpoint_491/docker compose down<br>
Tu turn off and delete any changes<br>
./Docker_POCE_Midpoint_491/docker compose down -v<br>
