# Create an Azure App Service Web App...

## Lab 1: ...by using Azure Portal

#### Task 1: Sign in to the Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a web browser.

1. Go to *(<https://portal.azure.com>)*.

1. Enter the email address of your Microsoft account. Click **Next**.

1. Enter the password for your Microsoft account.

1. Click **Sign In**.

</details>

#### Task 2: Locate the Web App in the Azure Marketplace

<details>
<summary>Click here to display answers</summary>

1. In the menu on the left, click **Create a resource**

1. On the **New** blade under the **Azure Marketplace** menu, click **Web**

1. Under **Featured** on the right side of the blade, click **Web App**

</details>

#### Task 3: Create a Web App

<details>
<summary>Click here to display answers</summary>

1. On the **Web App** blade under **App name**, enter a unique name 

    > **Note:** Once you enter a name that is available, you will see a green check mark on the right side of the **App name** box. Web app names must be unique across all existing Web app names in Azure. It must be 3-60 characters long. The URL to your Web App will use the domain name .azurewebsites.net. For example, the URL for your Web App will be similar to http://contoso.azurewebsites.net

1. In the **Subscription** dropdown menu, select your valid and active subscription

1. Under **Resource group**, leave the radio button to **Create New** and enter a unique name

    _For instance: "az203-rg"_

1. Leave the default **OS** selection to **Windows**

    > **Note:** On Windows, you can host any type of application from a variety of technologies. The same applies to Linux hosting, though on Linux, any ASP<span></span>.NET apps must be ASP<span></span>.Net Core on the .NET Core framework.

1. Leave the default **Publish** selection to **Code**

1. Click **App Service plan/Location**

    Note: An App Service plan is the container for your app. The App Service plan settings will determine the location, features, cost, and compute resources associated with your app. [Click here to learn more about Azure App Service plans](https://docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans).

1. On the **App Service plan** blade, click **Create new**

1. On the **New App Service plan** blade, under **App Service plan**, enter a unique name 

    _For instance: "az203-serviceplan"_

1. In the Location dropdown menu, choose the location that is geographically nearest to you

    _Select France Central_

    **Note: ** You can find the nearest region by using the [Microsoft Azure Region Map](https://map.buildazure.com/).

1. Click **Pricing tier**, navigate to the **Dev / Test** tab, and under **Recommended pricing tiers**, select **F1** and then click **Apply**

    > **Note:** Estimates are displayed for each pricing tier. For more pricing information, see [App Service Pricing](https://azure.microsoft.com/en-us/pricing/details/app-service/windows/).

1. On the **New App Service Plan** blade, click **OK**

1. On the **Web App** blade, leave the **Application Insights** selection to **Disabled**

    > **Note:** Application Insights helps you detect and diagnose quality issues in your .NET web apps and web services, and helps you better understand what your users actually do with your app.

1. Click **Create**

</details>

#### Task 4: Navigate to the created Web App

<details>
<summary>Click here to display answers</summary>

1. In the **Favorites** menu, click **App Services**

1. On the **App Services** blade, click the **Name** of the Web App that you created in the previous task

1. On the **App Service** blade, in the **Overview** pane, click the link under **URL**

    > **Note:** This will open a new browser tab and display a web site that says **"Your App Service app is up and running"** which confirms that the web app is available over the public Internet.

</details>

#### Task 5: Delete the Web App, the App Service Plan and the Resource Group

<details>
<summary>Click here to display answers</summary>

1. On the **App Service** blade, in the **Overview** pane, click **Delete**

    > **Note:** You can also delete the Web App from the **App Services** or from the **All resources** blades.

1. On the confirmation blade, under **TYPE THE APP NAME**, type the name of the Web App

1. Leave the **Delete App Service plan** to **Yes** in order to delete the associated App Service plan

    > **Note:** The default value is set to **Yes** if this is the last app in the App Service plan.

1. Click **Delete**

1. On the **Resource groups** blade, select the resource group you previously created, click **...**, then **Delete resource group**

1. On the confirmation blade, under **TYPE THE RESOURCE GROUP NAME**, type the name of the resource group

    > **Note:** The list of all resources included in the resource group will be listed. These resources will also be deleted.

1. Click **Delete**

1. On the **All resources** blade, you can confirm the deletion of all resources created during this lab

</details>

## Lab 2: ...by using Azure CLI

#### Task 1: Sign in to the Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a web browser.

1. Go to *(<https://portal.azure.com>)*.

1. Enter the email address of your Microsoft account. Click **Next**.

1. Enter the password for your Microsoft account.

1. Click **Sign In**.

</details>

#### Task 2: Open the Cloud Shell on Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Launch **Cloud Shell** from the top navigation of the Azure portal.

    ![Cloud Shell icon](https://docs.microsoft.com/en-us/azure/cloud-shell/media/overview/portal-launch-icon.png)

1. Select **Bash** in the bottom pane

1. Under **Subscription**, select a valid and active subscription

1. Click **Create storage**

    > **Note:** The **Cloud Shell** feature requires a storage account. This storage account will be reused for all usage of the **Cloud Shell** feature.

1. Check that the environment dropdown menu from the left-hand side of shell window says **Bash**.

    ![Cloud Shell environment](https://docs.microsoft.com/en-us/azure/cloud-shell/media/quickstart/env-selector.png)

</details>

#### Task 3: List all the regions by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following commands:

    az appservice list-locations

    > **Note:** [Click here to consult the **az appservice list-locations** command documentation](https://docs.microsoft.com/en-us/cli/azure/appservice?view=azure-cli-latest#az-appservice-list-locations)

1. Locate your nearest location, and copy the **name** attribute on a text file

</details>

#### Task 4: Create a Resource Group by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following commands:

    az group create --location francecentral --name "az203long-rg"

    az group create -l francecentral -n "az203short-rg"

    > **Note:** [Click here to consult the **az group create** command documentation](https://docs.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-create)

1. In the shell, type the following command:

    az group list

    > **Note:** [Click here to consult the **az group list** command documentation](https://docs.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-list)

1. In the shell, type the following commands:

    az group show --name "az203long-rg"

    az group show -n "az203short-rg"

    > **Note:** [Click here to consult the **az group show** command documentation](https://docs.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-show)

</details>

#### Task 5: Create a App Service plan by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following commands:

    az appservice plan create --name "az203long-serviceplan" --resource-group "az203long-rg" --location francecentral --sku F1

    az appservice plan create -n "az203short-serviceplan" -g "az203short-rg" -l francecentral --sku F1

    > **Note:** [Click here to consult the **az appservice plan create** command documentation](https://docs.microsoft.com/en-us/cli/azure/appservice/plan?view=azure-cli-latest#az-appservice-plan-create)

1. In the shell, type the following command:

    az appservice plan list

    > **Note:** [Click here to consult the **az appservice plan list** command documentation](https://docs.microsoft.com/en-us/cli/azure/appservice/plan?view=azure-cli-latest#az-appservice-plan-list)

1. In the shell, type the following commands:

    az appservice plan show --name "az203long-serviceplan" --resource-group "az203long-rg"

    az appservice plan show -n "az203short-serviceplan" -g "az203short-rg"

    > **Note:** [Click here to consult the **az appservice plan show** command documentation](https://docs.microsoft.com/en-us/cli/azure/appservice/plan?view=azure-cli-latest#az-appservice-plan-show)

</details>

#### Task 6: Create a Web App by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, replace **"XXXXX"** by a unique name and type the following commands:

    az webapp create --name "az203-webapp-long-XXXXX" --plan "az203long-serviceplan" --resource-group "az203long-rg"

    az webapp create -n "az203-webapp-short-XXXXX" -p "az203short-serviceplan" -g "az203short-rg"

    > **Note:** [Click here to consult the **az webapp create** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-create).

1. In the shell, type the following command:

    az webapp list

    > **Note:** [Click here to consult the **az webapp list** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-list).


1. In the shell, replace the name of the created web apps and type the following commands:

    az webapp show --name "az203-webapp-long-XXXXX" --resource-group "az203long-rg"

    az webapp show -n "az203-webapp-short-XXXXX" -g "az203short-rg"

    > **Note:** [Click here to consult the **az webapp show** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-show).

</details>

#### Task 7: Restart Web App by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, replace the name of the created web apps and type the following commands:

    az webapp restart --name "az203-webapp-long-XXXXX" --resource-group "az203long-rg"

    az webapp restart -n "az203-webapp-short-XXXXX" -g "az203short-rg"

    > **Note:** [Click here to consult the **az webapp restart** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-restart).

1. In the shell, type the following command:

    az webapp list --query "[?state=='Running']"

    > **Note:** [Click here to consult the **az webapp list** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-list).

</details>

#### Task 7: Delete Web App by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, replace the name of the created web apps and type the following commands:

    az webapp delete --name "az203-webapp-long-XXXXX" --resource-group "az203long-rg"

    az webapp delete -n "az203-webapp-short-XXXXX" -g "az203short-rg"

    > **Note:** [Click here to consult the **az webapp delete** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-delete).

1. In the shell, type the following command:

    az webapp list --query "[?state=='Running']"

    > **Note:** [Click here to consult the **az webapp list** command documentation](https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-list).

</details>

#### Task 8: Delete a App Service plan by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following commands:

    az appservice plan delete --name "az203long-serviceplan" --resource-group "az203long-rg"

    az appservice plan delete -n "az203short-serviceplan" -g "az203short-rg"

    > **Note:** [Click here to consult the **az appservice plan delete** command documentation](https://docs.microsoft.com/en-us/cli/azure/appservice/plan?view=azure-cli-latest#az-appservice-plan-delete)

1. In the shell, type the following command:

    az appservice plan list

    > **Note:** [Click here to consult the **az appservice plan list** command documentation](https://docs.microsoft.com/en-us/cli/azure/appservice/plan?view=azure-cli-latest#az-appservice-plan-list)

</details>

#### Task 9: Delete a Resource Group by using Azure CLI

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following commands:

    az group delete --name "az203long-rg"

    az group delete -n "az203short-rg"

    > **Note:** [Click here to consult the **az group delete** command documentation](https://docs.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-delete)

1. In the shell, type the following command:

    az group list

    > **Note:** [Click here to consult the **az group list** command documentation](https://docs.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-list)

</details>

## Lab 3: ...by using Azure Powershell

#### Task 1: Sign in to the Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a web browser.

1. Go to *(<https://portal.azure.com>)*.

1. Enter the email address of your Microsoft account. Click **Next**.

1. Enter the password for your Microsoft account.

1. Click **Sign In**.

</details>

#### Task 2: Open the Cloud Shell on Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Launch **Cloud Shell** from the top navigation of the Azure portal.

    ![Cloud Shell icon](https://docs.microsoft.com/en-us/azure/cloud-shell/media/overview/portal-launch-icon.png)

1. Check that the environment dropdown menu from the left-hand side of shell window says **Bash** and select **PowerShell**

    ![Cloud Shell environment](https://docs.microsoft.com/en-us/azure/cloud-shell/media/quickstart-powershell/environment-ps.png)

1. Confirm switching to **PowerShell** and wait for the Azure drive to be built

</details>

#### Task 3: List all the regions by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following commands:

    Get-AzureRmLocation

    > **Note:** [Click here to consult the **Get-AzureRmLocation** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermlocation

1. Locate your nearest location, and copy the **name** attribute on a text file

</details>

#### Task 4: Create a Resource Group by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following command:

    New-AzureRmResourceGroup -Name "az203-rg" -Location "France Central"

    > **Note:** [Click here to consult the **New-AzureRmResourceGroup** command documentation](https://docs.microsoft.com/en-us/powershell/module/AzureRm.Resources/New-AzureRmResourceGroup)

1. In the shell, type the following command:

    Get-AzureRmResourceGroup

    > **Note:** [Click here to consult the **Get-AzureRmResourceGroup** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup)

1. In the shell, type the following command:

    Get-AzureRmResourceGroup -Name "az203-rg"

</details>

#### Task 5: Create a App Service plan by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following command:

    New-AzureRmAppServicePlan -Name "az203-serviceplan" -ResourceGroupName "az203-rg" -Location "France Central" -Tier "Free"

    > **Note:** [Click here to consult the **New-AzureRmAppServicePlan** command documentation](https://docs.microsoft.com/en-us/powershell/module/AzureRM.Websites/New-AzureRmAppServicePlan)

1. In the shell, type the following command:

    Get-AzureRmAppServicePlan

    > **Note:** [Click here to consult the **Get-AzureRmAppServicePlan** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/get-azurermappserviceplan)

1. In the shell, type the following command:

    Get-AzureRmAppServicePlan -Name "az203-serviceplan"

</details>

#### Task 6: Create a Web App by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, replace **"XXXXX"** by a unique name and type the following command:

    New-AzureRmWebApp -Name "az203-webapp-XXXXX" -AppServicePlan "az203-serviceplan" -ResourceGroupName "az203-rg"

    > **Note:** [Click here to consult the **New-AzureRmWebApp** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/New-AzureRmWebApp).

1. In the shell, type the following command:

    Get-AzureRmWebApp

    > **Note:** [Click here to consult the **Get-AzureRmWebApp** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/get-azurermwebapp).


1. In the shell, replace the name of the created web app and type the following command:

    Get-AzureRmWebApp -Name "az203-webapp-XXXXX"

</details>

#### Task 7: Restart Web App by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, replace the name of the created web app and type the following commands:

    Restart-AzureRmWebApp -Name "az203-webapp-XXXXX" -ResourceGroupName "az203-rg"

    > **Note:** [Click here to consult the **Restart-AzureRmWebApp** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/restart-azurermwebapp).

</details>

#### Task 8: Delete Web App by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, replace the name of the created web app and type the following command:

    Remove-AzureRmWebApp -Name "az203-webapp-XXXXX" -ResourceGroupName "az203-rg"

    > **Note:** [Click here to consult the **Remove-AzureRmWebApp** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/remove-azurermwebapp).

1. In the shell, type the following command:

    Get-AzureRmWebApp -Name "az203-webapp-XXXXX"

</details>

#### Task 9: Delete a App Service plan by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following command:

    Remove-AzureRmAppServicePlan -Name "az203-serviceplan" -ResourceGroupName "az203-rg"

    > **Note:** [Click here to consult the **Remove-AzureRmAppServicePlan** command documentation](https://docs.microsoft.com/en-us/powershell/module/AzureRM.Websites/Remove-AzureRmAppServicePlan)

1. In the shell, type the following command:

    Get-AzureRmAppServicePlan

    > **Note:** [Click here to consult the **Get-AzureRmAppServicePlan** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/get-azurermappserviceplan)

</details>

#### Task 10: Delete a Resource Group by using Azure PowerShell

<details>
<summary>Click here to display answers</summary>

1. In the shell, type the following command:

    Remove-AzureRmResourceGroup -Name "az203-rg"

    > **Note:** [Click here to consult the **Remove-AzureRmResourceGroup** command documentation](https://docs.microsoft.com/en-us/powershell/module/AzureRm.Resources/Remove-AzureRmResourceGroup)

1. In the shell, type the following command:

    Get-AzureRmResourceGroup

    > **Note:** [Click here to consult the **Get-AzureRmResourceGroup** command documentation](https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup)

</details>

## Lab 4: ... by using Visual Studio

> **Note:** Click here to consult the Microsoft documentation regarding the creation of a [.NET Core web app](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-get-started-dotnet) or for an [ASP.NET Framework web app](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-get-started-dotnet-framework).

#### Prerequisites

1. Install/update the latest version of [Visual Studio 2017](https://visualstudio.microsoft.com/vs/) (15.9.5 or more recent)

#### Task 1: Launch Visual Studio 2017

<details>
<summary>Click here to display answers</summary>

1. Open the **Start** menu (Windows menu)

1. Search **"Visual Studio 2017"**

1. Launch **Visual Studio 2017**

</details>

#### Task 2: Create an ASP<span></span>.NET Core web project

<details>
<summary>Click here to display answers</summary>

1. In Visual Studio, create a project by selecting **File** > **New** > **Project**

1. In the **New Project** dialog, select **Visual C#** > **Web** > **ASP<span></span>.NET Core Web Application**

1. Name the application *az203webApp*

1. Leave the other default values

1. Click **OK**

1. In the **New ASP<span></span>.NET Core Web Application** dialog, select the **Web Application (Model-View-Controller)** template

1. Leave the other default values

1. Click **OK**

</details>

#### Task 3: Debug locally the Web App

<details>
<summary>Click here to display answers</summary>

1. From the menu, select **Debug** > **Start Debugging** to run the web app locally

1. If an information dialog pop up asking if you **"Would like to trust the IIS Express SSL certificate?"**, click **Yes**, then click **Yes** when a warning dialog pop up asking **"Do you want to install this certificate?"**

1. A web browser will open and display the web app

1. In Visual Studio, from the menu, select **Debug** > **Stop Debugging**

</details>

#### Task 4: Publish the Web App from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the *az203webApp* project and select Publish

1. In the publish wizard, leave the selection to **App Service**, and leave the option to **Create New**

1. Click **Publish**

1. In the **Create App Service dialog**, click **Add an account**, and sign in to your Azure subscription. If you're already signed in, select the account you want from the dropdown.

1. Under **App Name**, enter a unique name

1. Under **Subscription**, selct a valid and active subscription

1. Under **Resource Group**, click **New...**, enter *az203-rg*, then click **OK**

1. Under **Hosting Plan**, click **New...**

1. In the **Configure Hosting Plan** dialog, under the **App Service Plan**, enter *az203-serviceplan*

1. Under **Location**, select the nearest location

1. Under **Size**, leave the default value to **S1**

1. Click **OK**

1. Under **Application Insights**, leave the default value to **None**

1. Click **Create**

</details>