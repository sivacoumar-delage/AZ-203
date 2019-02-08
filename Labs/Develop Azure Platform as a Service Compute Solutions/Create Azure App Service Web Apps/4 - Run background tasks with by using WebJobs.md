# Run background tasks with by using WebJobs

## Lab 1: Create manually triggered WebJobs

#### Task 1: Prepare a Windows Batch script

<details>
<summary>Click here to display answers</summary>

1. Create a file named *HelloWorld.bat*

1. Edit the script and add the following commands:

    @set hh=%TIME:~0,2%<br />
    <br />
    @if %hh%==0 set hh=00<br />
    @if %hh%==1 set hh=01<br />
    @if %hh%==2 set hh=02<br />
    @if %hh%==3 set hh=03<br />
    @if %hh%==4 set hh=04<br />
    @if %hh%==5 set hh=05<br />
    @if %hh%==6 set hh=06<br />
    @if %hh%==7 set hh=07<br />
    @if %hh%==8 set hh=08<br />
    @if %hh%==9 set hh=09<br />
    <br />
    @echo Hello World from Windows Batch ! Today is %DATE% and it's %hh%:%TIME:~3,2%:%TIME:~6,2%.

    > **Note:** If you want to test locally, add a @pause in the end, but remove this instruction before uploading to Azure

1. Compress the file in zip archive named *WindowsBatch.zip*

</details>

#### Task 2: Create a manually triggered Windows Batch script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualWindowsBatch*

1. Under **File Upload**, select the zip created in the previous task

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Manual**

1. Click **OK**

</details>

#### Task 3: Run and check the logs of the Windows Batch script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed.

1. Close the **WebJob Run details** page

</details>

#### Task 4: Prepare a PowerShell script

<details>
<summary>Click here to display answers</summary>

1. Create a file named *HelloWorld.ps1*

1. Edit the script and add the following commands:

    $WarningPreference = "SilentlyContinue"<br />
    <br />
    $date = Get-Date -Format yyyy'-'MM'-'dd<br />
    $time = Get-Date -Format HH':'mm':'ss<br />
    $message = "Hello world from PowerShell ! Today is " + $date + " and it's " + $time + " !"<br />
    echo $message

    > **Note:** If you want to test locally, add the following lines in the end, but remove these instructions before uploading to Azure<br />Write-Host -NoNewLine 'Press any key to continue...';<br />$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

1. Compress the file in zip archive named *PowerShell.zip*

</details>

#### Task 5: Create a manually triggered PowerShell script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualPowerShell*

1. Under **File Upload**, select the zip created in the previous task

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Manual**

1. Click **OK**

</details>

#### Task 6: Run and check the logs of the PowerShell script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

    > **Note:** WebJob logs are displayed in **Kudu**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed.

1. Close the **WebJob Run details** page

</details>

#### Task 7: Prepare a Bash script

<details>
<summary>Click here to display answers</summary>

1. Create a file named *HelloWorld<span>.</span>sh*

1. Edit the script and add the following commands:

    #!/bin/bash

    currentdate=\`date +"%Y-%m-%d"\`<br />
    currenttime=\`date +"%T"\`<br />
    echo "Hello World from Bash ! Today is ${currentdate} and it's ${currenttime} !";

    > **Note:** If you want to test locally, add the followinf line in the end, but remove this instruction before uploading to Azure<br />read -n1 -r -p "Press any key to continue..." key

1. Compress the file in zip archive named *Bash.zip*

</details>

#### Task 8: Create a manually triggered Bash script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualBash*

1. Under **File Upload**, select the zip created in the previous task

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Manual**

1. Click **OK**

</details>

#### Task 9: Run and check the logs of the Bash script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed.

1. Close the **WebJob Run details** page

</details>

#### Task 10: Prepare a Python script

<details>
<summary>Click here to display answers</summary>

1. Create a file named *HelloWorld<span>.</span>py*

1. Edit the script and add the following commands:

    \#!/usr/bin/env python<br />
    import datetime<br />
    <br />
    now = datetime.datetime.now()<br />
    print("Hello World from Python ! Today is " + now.strftime("%Y-%m-%d") + " and it's " + now.strftime("%H:%M:%S") + " !")

1. Compress the file in zip archive named *Python.zip*

</details>

#### Task 11: Create a manually triggered Python script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualPython*

1. Under **File Upload**, select the zip created in the previous task

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Manual**

1. Click **OK**

</details>

#### Task 12: Run and check the logs of the Python script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed.

1. Close the **WebJob Run details** page

</details>

#### Task 13: Prepare a PHP script

<details>
<summary>Click here to display answers</summary>

1. Create a file named *HelloWorld.php*

1. Edit the script and add the following commands:

    \<?php<br />
        print("Hello World from PHP ! Today is " . date("Y-m-d") . " and it's " . date("H:i:s") . " ! ");<br />
    ?>

1. Compress the file in zip archive named *PHP.zip*

</details>

#### Task 14: Create a manually triggered PHP script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualPHP*

1. Under **File Upload**, select the zip created in the previous task

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Manual**

1. Click **OK**

</details>

#### Task 15: Run and check the logs of the PHP script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed.

1. Close the **WebJob Run details** page

</details>

#### Task 16: Prepare a Javascript script

<details>
<summary>Click here to display answers</summary>

1. Create a file named *HelloWorld.js*

1. Edit the script and add the following commands:

    console.log("Hello World from Node.js");

1. Compress the file in zip archive named *Javascript.zip*

</details>

#### Task 17: Create a manually triggered Javascript script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualJavascript*

1. Under **File Upload**, select the zip created in the previous task

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Manual**

1. Click **OK**

</details>

#### Task 18: Run and check the logs of the Javascript script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed.

1. Close the **WebJob Run details** page

</details>

#### Task 19: Run and check the logs of the WebJob from Azure CLI

> **Note:** You can't create a WebJob by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, open **Cloud Shell** (switch to **Bash** if needed)

1. In the shell, replace *XXXXX* and type the following command:

    az webapp webjob triggered list --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp webjob triggered list** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/webjob/triggered?view=azure-cli-latest#az-webapp-webjob-triggered-list)

1. In the shell, replace *XXXXX* and type the following command:

    az webapp webjob triggered run --webjob-name manualBash --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp webjob triggered run** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/webjob/triggered?view=azure-cli-latest#az-webapp-webjob-triggered-run)

1. In the shell, replace *XXXXX* and type the following command:

    az webapp webjob triggered log --webjob-name manualBash --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp webjob triggered log** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/webjob/triggered?view=azure-cli-latest#az-webapp-webjob-triggered-log)

    > **Note:** Logs are not displayed. Only the history of runs is displayed.

</details>

#### Task 20: Remove all WebJobs from Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, open **Cloud Shell**

1. In the shell, replace *XXXXX* and type the following commands:

    az webapp webjob triggered remove --webjob-name manualWindowsBatch --name az203webApp-XXXXX --resource-group az203-rg

    az webapp webjob triggered remove --webjob-name manualPowerShell --name az203webApp-XXXXX --resource-group az203-rg

    az webapp webjob triggered remove --webjob-name manualBash --name az203webApp-XXXXX --resource-group az203-rg

    az webapp webjob triggered remove --webjob-name manualPython --name az203webApp-XXXXX --resource-group az203-rg

    az webapp webjob triggered remove --webjob-name manualPHP --name az203webApp-XXXXX --resource-group az203-rg

    az webapp webjob triggered remove --webjob-name manualJavascript --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp webjob triggered remove** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/webjob/triggered?view=azure-cli-latest#az-webapp-webjob-triggered-remove)

1. In the shell, replace *XXXXX* and type the following command:

    az webapp webjob triggered list --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp webjob triggered list** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/webjob/triggered?view=azure-cli-latest#az-webapp-webjob-triggered-list)

</details>

## Lab 2: Create scheduled WebJobs

#### Task 1: Create a scheduled Bash script WebJob from Azure Portal which must run every 15 seconds

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *manualBash*

1. Under **File Upload**, select the zip *Bash.zip* created in the previous lab

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Scheduled**

1. Under **CRON Expression**, type *0/15 0 \* \* \* \**

    > **Note:** [Click here to see information regarding CRON expressions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer#cron-expressions)

    > **Note:** You can test CRON expression in the website [crontab guru](https://crontab.guru/). <br />**Warning!** Seconds are not handled on this tool. You must skip the first parameter to test expressions.

1. Click **OK**

</details>

#### Task 2: Check the logs of the Bash script WebJob from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the **WebJobs** pane, right-click the WebJob created in the previous task and select **Run**

1. Right-click the WebJob created in the previous task and select **Logs**

1. Under **TIMING**, select the first link

1. Check that the *Hello World !* message is displayed every 15 seconds.

1. Close the **WebJob Run details** page

</details>

#### Task 1: Create a scheduled Bash script WebJob from Azure Portal which must run everyday at 23:45:00 in January, April, July and October

<details>
<summary>Click here to display answers</summary>

1. In the **Azure Portal**, go to the **App Service** page of your **Web App**

1. Under **SETTINGS**, select **WebJobs**

1. In the **WebJobs** pane, click **Add**

1. In the **Add WebJob** pane, under **Name** type *quarterlyBash*

1. Under **File Upload**, select the zip *Bash.zip* created in the previous lab

1. Under **Type**, select **Triggered**

1. Under **Triggers**, select **Scheduled**

1. Under **CRON Expression**, type *0 45 23 \*/1 1,4,7,10 \**

    > **Note:** [Click here to see information regarding CRON expressions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer#cron-expressions)

    > **Note:** You can test CRON expression in the website [crontab guru](https://crontab.guru/). <br />**Warning!** Seconds are not handled on this tool. You must skip the first parameter to test expressions.

1. Click **OK**

</details>

## Lab 3: Create continuous WebJobs from Visual Studio

#### Prerequisites

1. Close all instances of **Visual Studio**

1. From the **Windows Start** menu, search **Visual Studio Installer** and launch it

1. In the **Visual Studio Installer**, if prompted **update** the **Visual Studio Installer**

1. Install **Azure development workload**

#### Task 1: Create a new WebJobs-enabled project in your WebApp solution

<details>
<summary>Click here to display answers</summary>

> **Note:** [Click here to consult the documentation regarding the WebJobs-enabled project creation](https://docs.microsoft.com/en-us/azure/app-service/webjobs-dotnet-deploy-vs#createnolink).

1. In **Visual Studio**, open the solution containing the **WebApp** created in the previous module

1. Right-click the web project in **Solution Explorer**, and then click **Add** > **New Project...**

1. Under **Cloud**, select **Azure WebJob (.NET Framework)**

1. Under **Name**, type *ContinuousWebJob*

1. Under **Framework**, select the latest version the **.NET Framework**

1. Click **OK**

</details>

#### Task 2: Update the program to log a message every 15 seconds

<details>
<summary>Click here to display answers</summary>

1. In **Program.cs**, replace the content of the class by:

    private static int FIFTEEN_SECONDS = 15000;<br />
    <br />
    static void Main()<br />
    {<br />
        while(true)<br />
        {<br />
            Functions.WriteLog(Console.Out);<br />
            Thread.Sleep(FIFTEEN_SECONDS);<br />
        }<br />
    }<br />

1. In **Functions.cs**, replace the content of the class by:

    public static void WriteLog(TextWriter log)<br />
    {<br />
        var now = DateTime.UtcNow;<br />
        string message = $"Hello World ! Today is {now.ToLongDateString()} and it's {now.ToLongTimeString()} !";<br />
        log.WriteLine(message);<br />
    }

1. Build the project

</details>

#### Task 3: Deploy the WebJobs project

> **Note:** [Click here to consult the documentation regarding the WebJobs project deployment](https://docs.microsoft.com/en-us/azure/app-service/webjobs-dotnet-deploy-vs#deploy).

<details>
<summary>Click here to display answers</summary>

1. Right-click the web jobs project in **Solution Explorer**, and then click **Publish as Azure WebJob...**

1. In the **Add Azure WebJob** dialog, under **Project name:** type *ContinuousWebJob*

1. In the **Add Azure WebJob** dialog, under **WebJob name:** type *ContinuousWebJob*

1. In the **Add Azure WebJob** dialog, under **WebJob run mode:** type *Run Continuously*

1. Click **OK**

1. In the **Publish** wizard, select **Import**

1. Browse and select the *.PublishSettings* you downloaded in the previous module

1. Click **OK**

1. In the **Publish** wizard, click **Publish**

</details>

#### Task 4: Check the logs in Kudu

<details>
<summary>Click here to display answers</summary>

1. Navigate to the Web App

1. Add *.scm* before *.azurewebsites.net*

1. In **Kudu**, click **Tools**, then select **WebJobs dashboard**

1. Select *ContinuousWebJob*

1. Check that the logs are written every 15 seconds

</details>