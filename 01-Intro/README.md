# Session_01 - Intro to OnDemand and R

## Set up a project directory on LongLeaf

While everything we'll work on in this course will be using OnDemand, we want to keep our notebooks and files organized.

### 1. Open a terminal on your computer (Mac Terminal or Windows Mobaxterm). 

### 2. Connect to LongLeaf...
```
ssh [ONYEN]@longleaf.unc.edu
```

### 3. Then navigate to your `/work/` space.

```
cd /work/users/[First letter in Onyen]/[Second letter in Onyen]/[Onyen]
```

> [!NOTE]
> Longleaf has several different directory spaces available to users. 
> `/nas/longleaf/home`, `/proj`, `/work`, and `/users`.  
> When you connect you default start in your $HOME directory `/nas/longleaf/home/[Onyen]`.
> Home is a bad place to work because it has limited storage capacity.
> `/work` is designed for activate projects, the hardward supports faster read/write of files. You have a 10Tb storage capacity on `/work` but don't leave things there indeffinitely. 
> Use `/proj` or `/users` for long term storage of files you aren't actively using.  


### 4. Sync the contents of your `hsl-scRNA` directory with the main course directory.
We have set up a space on LongLeaf to store all example data and notebooks. We can use the `rsync` UNIX command to keep our new `hsl-scRNA` directory on `/work` up-to-date with the main one. 

```
rsync -av /overflow/scrnaseq/hsl-scRNA/ hsl-scRNA
```

This will create a new directory called hsl-scRNA. You can rerun the above command to update this directory before each class.
**But make sure not to run it inside the hsl-scRNA directory, you must be in your main work directory, one level above `hsl-scRNA/` for this command to work correctly.

>[!NOTE]
> Any changes made to files within the repository will be **overwritten** by `rsync`.
> If you want to make notes or edits to any of the course material -- you should make a personal copy so you don't lose your work by accident.

#### Alternative - Getting files from Github

If you have a Github account and experience using `git` then you can also get and keep up with course material by simply cloning this repo into your `/work` space. Make sure you `pull` any updates before each class. 

```
git clone git@github.com:mniederhuber/hsl-scRNA.git
```

## Intro to OnDemand

### 1. Connecting to OnDemand

We will be working in RStudio using OnDemand, which is a platform that provides a simplified point of acces to high-performance computing (HPC) resources at UNC.

To login into the UNC OnDemand portal go to `ondeamnd.rc.unc.ed`

Enter your UNC Onyen and follow the prompts. 

> [!NOTE] 
> If you are working off-campus you'll first have to connect to the university VPN. see: https://ccinfo.unc.edu/start-here/secure-access-on-and-off-campus/

### 2. Starting RStudio

From the OnDemand platform we can launch a number of different apps on the UNC HPC cluster LongLeaf. We can run Jupyter notebooks, RStudio, and Matlab. We can also launch apps that give us a simulated desktop GUI for working on LongLeaf.

Let's start an RStudio Server job. 

Go to the `Apps` drop-down menu and select `RStudio Server`.

You should see a page that says RStudio Server at the top and a number of input boxes to specify the environment and resources for our job. 

- R version 
    - we'll be working with R 4.4.0 
- Additional Job Submission Arguments
    - we will request additional memory with `--mem=100G`
    - this is overkill for most work but sc datasets often require some memory-intensive operations so better to request a lot
- Number of hours
    - `2`
- Number of CPUs
    - `1`

Once you've added all these specifications click `Launch`

You should be automatically taken to the `My Interactive Sessions` page, which will show the job you've just submitted. 

Once the job starts to run you should see a `Connect to RStudio Server` button. *Sometimes a page refresh helps*

### 3. Intro to RStudio

When you connect to your RStudio job it will automatically load some environment settings and most likely set your personal $HOME directory as the working directory.

> [!NOTE]
> You can customize your rstudio preferences in Tools > Global Options...
> OnDemand automatically sources preferences saved in `$HOME/.config/rstudio/rstudio-prefs.json` 
> So you can set up RStudio how you like and it will be the same every time you launch with OnDemand

RStudio is an Interactive Development Environment (IDE) for using the R programming language. It provides a point-and-click interface as well as command line, script running, and notebook functionalities. 
RStudio has a multi-pane layout. A **source** pane, a **console/terminal** pane, an **environment** pane, and a **files/plots/help/etc** pane. 
The source pane shows actively open R scripts or notebooks.
The console/terminal pane provides a R console for running R functions, and a unix terminal to interact with your file system. 

First let's set the working directory to the class directory we just made in `/work`. 

In the RStudio console run (replace {PATH TO DIR} with your personal project directory path you just made.):
```
setwd('{PATH TO DIR}')
```

Then in the files pane, click on the "gear" icon and select "Go To Working Directory".

You should now see all the files in our class directory.

The material for today is under `01-Intro`.
There you'll find a comprehensive introduction to RStudio and R with more detail then we have time to go through today. 

For now open a new notebook by clicking File > New File > R Notebook

The rest of this section will be interactive and will be a summary of the content in `01-Intro/01-Intro.Rmd`

