# Debugging and monitoring a Web App

## Prerequisites

1. Know how to create a Web App
1. Know how to configure and use Cloud Shell

## Lab 1: Remote debugging

#### Task 1: Set a breakpoint in the About controller

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, open the class in **Controllers** > **HomeController**

1. In the **HomeController**, add a breakpoint on the first instruction of the method **About**

1. Start debugging locally

1. Navigate to the **About** page

1. Check that the breakpoint is hit

1. Stop debugging

</details>

#### Task 2: Publish a Debug version of the Web App on Azure

<details>
<summary>Click here to display answers</summary>

1. Select the **Build** > **Publish az203webApp** menu

1. Click **Configure**

1. In the **Publish** dialog, under the **Settings** tab, select **Debug** in the **Configuration** dropdown

1. Click **Publish**

</details>

#### Task 3: Debug the published Web App on Azure from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, open **Server Explorer** (**View** > **Server Explorer**)

1. In **Server Explorer**, expand Azure, then expand **App Service**

1. Expand the resource group containing the **Web App** to debug (*az203-rg*), right-click on the **Web App** and choose **Attach Debugger**

    The Web App will open in a web browser.

1. In the running ASP.NET application, navigate to the **About** page

    The breakpoint should be hit in Visual Studio.

    > **Note:** The breakpoint will be hit only if the deployed **Configuration** has been set to **Debug** (see **Task 2**).

</details>

## Lab 2: Kudu

#### Task 1: Open Kudu associated to your Web App in the web browser

<details>
<summary>Click here to display answers</summary>

1. In the **Favorites** menu, click **App Services**

1. On the **App Services** blade, click the **Name** of the Web App that you created in the previous module

1. On the **App Service** blade, in the **Overview** pane, click the link under **URL**

1. In the URL, add ".scm" before ".azurewebsites.net"

1. If prompted, sign-in with your Azure credentials

</details>

#### Task 2: Check application settings in Kudu

<details>
<summary>Click here to display answers</summary>

1. In the home page, click **App Settings**

    *You should be able to see the custom settings we added in the previous module (ApplicationSettings:BackgroundColor and ApplicationSettings:Environment)*

</details>

#### Task 3: Check envrionment information in Kudu

<details>
<summary>Click here to display answers</summary>

1. Go back to Kudu home page

1. In the home page, click **Environment**

    *You should be able to see the custom settings we added in the previous module (ApplicationSettings:BackgroundColor and ApplicationSettings:Environment)*

</details>

#### Task 4: Check the processes in Kudu

<details>
<summary>Click here to display answers</summary>

1. In the top menu, click **Process explorer**

1. Click **Properties** on donet.exe

    > **Note:** you can kill or download memory dump on running processes if needed.

1. Click **Close**

</details>

#### Task 5: Download Diagnostic dumps in Kudu

<details>
<summary>Click here to display answers</summary>

1. In the top menu, click **Tools**, then select **Diagnostic dump**

</details>

#### Task 6: Browse the web files with the CMD console in Kudu

<details>
<summary>Click here to display answers</summary>

1. In the top menu, click **Debug console**, then select **CMD**

1. Type the following commands:

    dir
    cd site
    dir
    cd wwwroot
    dir

</details>

#### Task 7: Browse the web files with the PowerShell console in Kudu

<details>
<summary>Click here to display answers</summary>

1. In the top menu, click **Debug console**, then select **PowerShell**

1. Type the following commands

    Get-ChildItem -Recurse | Select-Object -ExpandProperty FullName

</details>

## Lab 3: Enable diagnostics logging

#### Task 1: Enable diagnostics from Azure Portal

<details>
<summary>Click here to display answers</summary>

> **Note:** [Click here to see the documentation to enable diagnostics logging](https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs).

1. Open a web browser and go to the [**Azure Portal**](https://portal.azure.com/)

1. In the **Favorites** menu, click **App Services**

1. On the **App Services** blade, click the **Name** of the Web App that you created in the previous module

1. Under **Monitoring**, click **Diagnostics logs**

1. Under **Application Logging (Filesystem)**, click **On**

1. Under **Level**, select **Verbose** to get all levels of logs

    | Level 	    | Included log categories                                           |
    |---------------|:-----------------------------------------------------------------:|
    | Disabled 	    | None                                                              |
    | Error 	    | Error, Critical                                                   |
    | Warning 	    | Warning, Error, Critical                                          |
    | Information   | Info, Warning, Error, Critical                                    |
    | Verbose 	    | Trace, Debug, Info, Warning, Error, Critical (all categories)     |


1. Under **Application Logging (Blob)**, click **On**

1. Under **Level**, select **Verbose** to get all levels of logs

1. Under **Storage Settings**, click **Storage not configured**

1. In the **Storage accounts** pane, click **Storage account**

1. In the **Create storage account**, under **Name**, type a unique name

1. Under **Account kind**, leave the default selection

1. Under **Performance**, leave the default selection to **Standard**

1. Under **Replication**, leave the default selection to **LRS**

1. Click **OK**

1. In the **Storage accounts** pane, click **Refresh**, then select the storage account you previously created

1. In the **Containers** pane, click **Container**

1. Under **Name**, type *logs*

1. Under **Public access level**, select **Blob (anonymous read access for blobs only)**

    > **Note:** Currently, only blob storage is supported for diagnostic logs

1. Click **OK**

1. In the **Containers** pane, select *logs*

1. Click **Select**

1. Under **Retention Period (Days)**, type *30*

1. Under **Web server logging**, select **File System**

1. Leave the default values for **Quota** and **Retention Period (Days)**

1. Under **Retention Period (Days)**, type *30*

1. Under **Details error messages**, click **On**

1. Under **Failed request tracing**, click **On**

1. Click **Save**

</details>

#### Task 2: Go to the Web App and navigate between pages to generate logs

#### Task 3: Download diagnostics logs from FTP

<details>
<summary>Click here to display answers</summary>

1. Open a FTP tool

    Such as [Filezilla](https://filezilla-project.org/)

1. Go back to Azure Portal

1. In the **Diagnostics logs** blade, copy the **FTP/deployment username** and paste it as **Username** in your FTP tool

1. In the **Diagnostics logs** blade, copy the **FTP hostname** and paste it as **Host** in your FTP tool

1. In the **Diagnostics logs** blade, copy the **FTPS hostname** and paste it as **Host** in your FTP tool

1. Click **Deployment Center**

1. Click FTP, then click **Dashboard**

1. In the **FTP** pane, click **User Credentials**

1. Define a password under **Password** and **Confirm Password** and click **Save Credentials**

1. Type the same **Password** in your FTP tool

1. Click **Connect** in your FTP tool

1. Accept the certificate

1. Go to **LogFiles**

1. Download and open the files under **Application** and **DetailedErrors**

</details>

#### Task 4: Disable diagnostics logs from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Go back to Azure Portal

1. Click **Diagnostics logs**

1. Under **Application Logging (Filesystem)**, click **Off**

1. Under **Application Logging (Blob)**, click **Off**

1. Under **Web server logging**, select **Off**

1. Under **Details error messages**, click **Off**

1. Under **Failed request tracing**, click **Off**

1. Click **Save**

</details>

#### Task 4: Enable diagnostics from Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, click **Home**

1. Launch **Cloud Shell** from the top navigation of the Azure portal.

    ![Cloud Shell icon](https://docs.microsoft.com/en-us/azure/cloud-shell/media/overview/portal-launch-icon.png)

1. Check that the environment dropdown menu from the left-hand side of shell window says **Bash**

    *If it says **PowerShell**, switch to **Bash***

1. In order to enable the diagnostics logs, replace the XXXXX and type the following command:

    az webapp log config --name az203webApp-XXXXX --resource-group az203-rg --application-logging true --detailed-error-messages true --failed-request-tracing true --web-server-logging filesystem

    > **Note:** [Click here to consult the **az webapp log config** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/log?view=azure-cli-latest#az-webapp-log-config)

1. In order to see the dignostics logs configuration, replace the XXXXX and type the following command:

    az webapp log show --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp log show** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/log?view=azure-cli-latest#az-webapp-log-show)

</details>

#### Task 5: Download diagnostics logs from Azure CLI

<details>
<summary>Click here to display answers</summary>

1. Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) on your computer

1. In your computer, open a new command prompt, PowerShell, Bash, or Terminal session

1. Connect to your account by using the following command:

    az login

    > **Note:** [Click here to consult the **az login** command documentation](https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest#az-login)

1. Sign-in the web browser

1. Go back to the command session

1. In order to download the dignostics logs, replace the XXXXX and type the following command:

    az webapp log download --name az203webApp-XXXXX --resource-group az203-rg --log-file webapp_logs.zip

    > **Note:** [Click here to consult the **az webapp log download** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/log?view=azure-cli-latest#az-webapp-log-download)

1. Go back to **Azure Portal**

1. In the **Cloud Shell**,replace the XXXXX and type the following command:

    az webapp log tail --name az203webApp-XXXXX --resource-group az203-rg

    > **Note:** [Click here to consult the **az webapp log tail** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/log?view=azure-cli-latest#az-webapp-log-tail)

1. Go to the Web App and navigate between pages to generate logs

1. Go back to **Azure Portal**, and check the logs in the **Cloud Shell**

1. Close the **Cloud Shell**

</details>

#### Task 6: Disable diagnostics logs from Azure CLI

<details>
<summary>Click here to display answers</summary>

1. Open the **Cloud Shell**

1. In order to disable the diagnostics logs, replace the XXXXX and type the following command:

    az webapp log config --name az203webApp-XXXXX --resource-group az203-rg --application-logging false --detailed-error-messages false --failed-request-tracing false --web-server-logging off

    *Currently, the command seems to be not working for all settings, disable from Azure Portal*

    > **Note:** [Click here to consult the **az webapp log config** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp/log?view=azure-cli-latest#az-webapp-log-config)

</details>