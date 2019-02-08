# Update a Web App

## Lab 1: Publish Profiles

#### Task 1: Download Publish Profiles from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a web browser and go to the [**Azure Portal**](https://portal.azure.com/)

1. In the **Favorites** menu, click **App Services**

1. On the **App Services** blade, click the **Name** of the Web App that you created in the previous module

1. In the **Overwiew** pane, click **Get publish profile**

1. Save the publish settings file on your computer

</details>

#### Task 2: Download Publish Profiles from Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In Azure Portal, open the Cloud Shell

1. Replace the web app name and type the following command:

    Get-AzureRmWebAppPublishingProfile -Name "az203webApp-XXXXX" -ResourceGroupName "az203-rg"

    > **Note:** [Click here to consult the **Get-AzureRmWebAppPublishingProfile** command documentation](https://docs.microsoft.com/en-us/powershell/module/AzureRM.Websites/Get-AzureRmWebAppPublishingProfile)

1. Copy and save the settings into a .PublishSettings file

</details>

#### Task 3: Import a Publish Profile from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the *az203webApp* project and select **Publish**

1. In the **Publish** pane, click **New Profile...**

1. In the **Pick a publish target**, click **Import Profile...**

1. Select the .PublishSettings file you previously downloaded

1. Click **Open**

    > **Note:** a new publication will occur.

</details>

#### Task 4: Redeploy the Web App

<details>
<summary>Click here to display answers</summary>

1. Select the **Build** > **Publish az203webApp** menu

1. Click **Publish**

</details>

## Lab 2: Application Settings

> **Note:** [Click here to consult the **Configuration in ASP.NET Core** documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/)

#### Task 1: Add an Application Settings for the background color in Visual Studio and set it to blue

<details>
<summary>Click here to display answers</summary>

1. In the *appsettings.json* file, add the following code

    > "ApplicationSettings": {<br />"BackgroundColor": "Orange"<br/>}

1. Open the page in **Views** > **Home** > **Index.cshtml**

1. Add in the beginning of the page

    > @using Microsoft.Extensions.Configuration<br />@inject IConfiguration Configuration<br/><br/>\<style><br/>body {<br/>background-color: @Configuration["ApplicationSettings:BackgroundColor"]<br/>}<br/>\</style>

1. Debug the application to see if the background color has been updated to Orange

</details>

#### Task 2: Redeploy the Web App

#### Task 3: Overwrite the Application Settings for the background color in Azure Portal and set it to green

<details>
<summary>Click here to display answers</summary>

1. Open a web browser and go to the [**Azure Portal**](https://portal.azure.com/)

1. In the **Favorites** menu, click **App Services**

1. On the **App Services** blade, click the **Name** of the Web App that you created in the previous module

1. Open the web app in a new tab and check that the background color is Orange

1. Click the **Application settings** blade

1. Under **Application settings**, click **+ Add new setting**

1. Under **APP_SETTING_NAME**, type *ApplicationSettings:BackgroundColor*

1. Under **VALUE**, type *YellowGreen*

1. Click **Save**

1. Refresh the Web App page in the other tab and check that the background color has been updated

</details>

## Lab 3: Deployment Slots

#### Task 1: Create a new Deployment Slot

<details>
<summary>Click here to display answers</summary>

1. Open a web browser and go to the [**Azure Portal**](https://portal.azure.com/)

1. In the **Favorites** menu, click **App Services**

1. On the **App Services** blade, click the **Name** of the Web App that you created in the previous module

1. Click the **Deployment slots (Preview)** blade

1. Click **Add Slot**

1. Under **Name**, type *staging*

1. Under **Clone settings from:**, leave the default value to **Do not clone settings**

1. Click **Add**

1. After slot creation, click **Close**

1. Under **NAME**, click the created slot

1. Under the **Overview** pane, click on the URL to go to the web app

    The web app is empty.

1. Close the web app page

</details>

> **Note:** [Click here to consult the Microsoft document to check how to **create staging environments**](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots)

#### Task 2: Get the Publish Profiles for the Deployment Slot

<details>
<summary>Click here to display answers</summary>

1. Under the **Overview** pane, click **Get publish profiles**

1. Save the .publishsettings file on your computer

</details>

#### Task 3: Define the title of the Home page of the Web App in the application settings and deploy to the staging Deployment Slot

<details>
<summary>Click here to display answers</summary>

1. In Visual Studio, open the file **appsettings.json**

1. Add under the *ApplicationSettings* section, a variable called *Environment* with the value *Local*

1. Open the page in **Views** > **Home** > **Index.cshtml**

1. Change the title of the home page from "Home Page" to "Home Page (" + @Configuration\["ApplicationSettings:Environment"] + ")"

1. Debug the Web App

    The title will display "Home Page (Local)".

1. Stop debugging the Web App

1. In the **Solution Explorer**, right-click the *az203webApp* project and select **Publish**

1. In the **Publish** pane, click **New Profile...**

1. In the **Pick a publish target**, click **Import Profile...**

1. Select the .PublishSettings file you previously downloaded for the *staging* deployment slot

1. Click **Open**

    A new publication will occur.

1. Click on the link in the **Output** pane in order to go to the staging web app

    > **Note:** The **Ctrl** key must be held while clicking on the link.

1. Check the title of the Home page

    The title will display "Home Page (Local)".
    As the setting *Environment* doesn't exist, the value will the one defined in local.

1. Check the color of the background on the *staging* environment

    As no setting was cloned, the default background color is the one defined in local.

</details>

#### Task 4: Overwrite the title and the background color to red in the staging Deployment Slot application settings

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, under *staging* Web App blade, click **Application settings**

1. Under **Application settings**, click **+ Add new setting**

1. Under **APP_SETTING_NAME**, type *ApplicationSettings:Environment*

1. Under **VALUE**, type *Staging*

1. Check the **SLOT SETTING**

1. Under **Application settings**, click **+ Add new setting**

1. Under **APP_SETTING_NAME**, type *ApplicationSettings:BackgroundColor*

1. Under **VALUE**, type *Tomato*

1. Click **Save**

1. Refresh the *staging* Web App page in the other tab and check that the background color has been updated

</details>

#### Task 5: Add the title setting in the production slot

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, go back to the production Web App

1. Under the **Application settings**, add new setting called *ApplicationSettings:Environment*, set its value to *Production* and check the **SLOT SETTING**

1. Open the Web App in another tab

</details>

#### Task 6: Swap Deployment Slots

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, under the **Overview** blade, click **Swap**

    The **Swap** pane will show information before swapping two slots. The setting(s) that will be swapped will be displayed as well.

1. Under the **Swap** pane, leave the default slots under **Source** and Under **Target**

1. Click **Swap**

1. After swap completion, click **Close** 

1. Refresh the production page and the staging page

    The *production* slot will contain the new version, but the *staging* slot will keep the previous version.
    
    The background color have been swapped between the *production* and the *staging* slots.

    > **Note:** [Click here to know **which setting are swapped**](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots#which-settings-are-swapped).

</details>

#### Task 7: Roll back the swap

<details>
<summary>Click here to display answers</summary>

1. Perform the same steps as in **Task 6**

1. Check that the old version is now in the *production* slot and that the new version is back to the *staging* slot

</details>

#### Task 8: Route the 50% of the traffic to the new version

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, in the **Web App**, click the **Deployment slots (Preview)** blade

1. Under **TRAFFIC %**, type *50* in the *staging* row

1. Click **Save**

1. Open the production link with another web browser

    If the new version doesn't open with another browser, use another one, or use a private session

</details>

## Next

### Debugging and monitoring

#### Task 1: Debug the published on Azure from Visual Studio