# dailyGarbo
This is IPB's script to do daily tasks and run Garbo.

!!RIGHT NOW IT WILL RUN FOR IPB AND NOBODY ELSE!!

What does it do?
----------------
This is a plug and play script that tries to run IPB's daily routine of breakfast, additional scripts, then garbo. 

The goal is to be able to push the button and have it do everything it needs to in order for a full day of meatfarming.

A lot of my supporting scripts need to be uploaded to github so this will work.

The script can be edited to add other scripts or routines as part of the day.

Here is how it works:
---------------------
Each group of activities are part of a section. The script keeps track of what sections are completed. You can run the script as many times as you want, and it will pick up at the start of the section it is currently on.

How do I use it?
----------------
First, install it by running this command in KoLmafia's graphical CLI:

Then look and edit for what you can use. This will work better once I add additional scripts to the dependencies.txt

<pre>
git checkout infopowerbroker/dailyGarbo release
</pre>

Once it's installed, go to the Scripts menu, then select "dailyGarbo.ash". This can be configured as part of the meatbutton.ash script I host elsewhere.

To update the script itself, run this command in the graphical CLI:

<pre>
git update
</pre>


