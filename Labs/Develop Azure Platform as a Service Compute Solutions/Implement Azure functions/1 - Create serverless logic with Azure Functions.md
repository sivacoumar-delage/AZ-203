# Create serverless logic with Azure Functions

## Lab 1: ...by using Azure Portal

#### Task 1: Creating a FunctionApp from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), click **Create a resource**

1. Under **Azure Marketplace**, click **Compute**

1. Under **Featured**, click **Function App**

1. In the **Function App** blade, under **App name**, replace XXXXX by a unique name and type *az203functions-XXXXX*

1. Under **Subscription**, select your active and valid subscription

1. Under **Resource Group**, select **Use existing**, then select the *az203-rg* resource group

1. Under **OS**, leave the default value to **Windows**

1. Under **Hosting Plan**, leave the default value to **Consumption Plan**

    > **Note:** Hosting plan that defines how resources are allocated to your function app. In the default **Consumption Plan**, resources are added dynamically as required by your functions. In this serverless hosting, you only pay for the time your functions run. When you run in an **App Service Plan**, you must manage the scaling of your function app.

1. Under **Location**, select the nearest location

1. Under **Runtime Stack**, select **.NET**

   > **Note:** Choose a runtime that supports your favorite function programming language. Choose .NET for C# and F# functions.

1. Under **Storage**, select **Use existing**, then select the *az203storageaccountXXXXX* you created in a previous module

1. Under **Application Insights**, leave the default selection

    > **Note:** Application Insights is enabled by default

1. Click **Create**

</details>

#### Task 2: Create an HTTP triggered function named HttpTriggeredFunction from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, under **Favorites**, click **App Services**

1. Select the **Function App** you created in the previous task

1. In the **Function Apps** pane, click **Functions**

1. Click **New function**

1. Click **HTTP trigger**

1. In the **HTTP trigger** pane, under **Name**, type *HttpTriggeredFunction*

1. Under **Authorization Level**, leave the default selection to **Function**

    > **Note:** Determines what keys, if any, need to be present on the request in order to invoke the function. The authorization level can be one of the following values:<br />
    <li><ul>**Function** — A function-specific API key is required. This is the default value if none is provided.</ul><ul>**Anonymous** — No API key is required.</ul><ul>**Admin** — The master key is required.</ul></li>

1. Click **Create**

</details>

#### Task 3: Edit the function's code to log a message containing the name of the function

<details>
<summary>Click here to display answers</summary>

1. In the function blade, under **run.csx** pane, edit the log.LogInformation instruction at line 10 with the following code:

    log.LogInformation("HttpTriggeredFunction function processed a request.");

1. Click **Save**

</details>

#### Task 4: Test the HTTP triggered function from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the function blade, click **Run**

1. In the bottom pane, check the **Logs**

1. In the right pane, check the **Request Body** and **Output**

1. In the right pane, update the **Request Body** with:

    {<br />"name": "from Azure Portal"<br />}

1. Click **Run**

1. Check the **Logs** and the **Output**

</details>

#### Task 5: Test the HTTP triggered function from the web browser

<details>
<summary>Click here to display answers</summary>

1. In the function blade, click **</> Get function URL**

1. In the **Get function URL** dialog, under **Key**, leave the default selection to **default (Function key)**

1. Copy the link under **URL**

1. Open a new tab, paste the URL and add *&name=from Web Browser* in the end of the URL

1. Press enter to execute the request

1. Check the response in the new tab

1. Close the tab

1. In the function blade, check the **Logs**

</details>

#### Task 6: Test the HTTP triggered function from Postman

<details>
<summary>Click here to display answers</summary>

1. Copy again the **function URL**

1. Open **Postman**

1. Under **New Tab**, switch from **GET** to **POST**

1. In the **Enter request URL**, paste the URL copied in the previous step

1. Click **Body**

1. Under **Body**, select **raw**

1. In the **Body** field, type the following request body:

    {<br />"name": "from Postman"<br />}

1. Click **Send**

1. In the bottom pane, check the **Status** code

    A *200 OK* response should be displayed

1. In the bottom pane, check the response

    *Hello, from Postman* should be displayed

1. In **Azure Portal**, in the function blade, check the **Logs**

</details>

#### Task 7: Test the HTTP triggered function from Bash by using cURL

<details>
<summary>Click here to display answers</summary>

1. Open a bash terminal (**Git Bash** for instance)

1. Replace xxxxx by the function key and type the following command:

    curl "xxxxx&name=from%20Bash"

1. Check the response

    *Hello, from Bash* should be displayed

1. Close the **Bash** terminal

</details>

#### Task 8: Test the HTTP triggered function from PowerShell

<details>
<summary>Click here to display answers</summary>

1. Open a **PowerShell** terminal

1. Replace xxxxx by the function key and type the following commands:

    \[Net.ServicePointManager]::SecurityProtocol = \[Net.SecurityProtocolType]::Tls12<br />
    Invoke-WebRequest -Uri "xxxxx&name=from PowerShell"

1. Check the response

    *Hello, from PowerShell* should be displayed in the **Content**

1. Close the **PowerShell** terminal

</details>

#### Task 9: Check the logs from the monitoring dashboard

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, in the function blade, under the *HttpTriggeredFunction* function, click **Monitor**

    The list of calls will be displayed

1. Click on the first row to see the logs associated to the latest call

1. In the **Invocation Details**, click on the first row to see the full message

    > **Note:** Results may be delayed for up to 5 minutes.

1. Close the **Invocation Details**

1. Click **Run in Application Insights**

1. Sign-in with the same account used in **Azure**

1. Click **CHART**

1. Close the **Application Insights** tab

</details>

#### Task 10: Edit the function's code to log the request query and request body

> **Note:** The request query and request body information are not displayed in the logs.

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, in the function blade, click the *HttpTriggeredFunction* function

1. Under **run.csx**, add the following instruction after the declaration and assignation of the variable *name*:

    log.LogInformation($"Request Query: {req.QueryString}");

1. Under **run.csx**, add the following instruction after the declaration and assignation of the variable *requestBody*:

    log.LogInformation($"Request Body: {requestBody}");

1. Click **Save and Run**

1. Check the **Logs**

    The request body should be logged

1. Test the function from a web browser

1. Check the **Logs**

    The request query should be logged

    > **Warning!** if you log the request query, the function key will be displayed in the logs.

</details>

## Lab 2: ...by using Visual Studio

#### Prerequisites

1. Install **Visual Studio 2017** with **Azure development workload** (version 15.5 or a later version).

1. In **Visual Studio 2017**, from the **Tools** menu, choose **Extensions and Updates**. Expand **Installed** > **Tools** and check that the tool **Azure Functions and Web Jobs Tools** is installed and is up to date. If the tools is not up to date, you can update it from **Updates**. If the tools is not installed, click on **Online**, search **Azure Functions and Web Jobs Tools** and install it.

1. Install [**Azure Storage Explorer**](https://azure.microsoft.com/en-us/features/storage-explorer/)

1. Install [**Azure Storage Emulator**](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-emulator)

#### Task 1: Create an HTTP triggered Azure function in Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Open **Visual Studio**, click the **File** menu, and select **New** > **Project**

1. In the **New Project** dialog, under **Installed** > **Visual C#** > **Cloud**, select **Azure Functions**

1. In the **Name** field, type *az203functions*

1. Click **OK**

1. In the **New Project - az203functions** dialog, select **Azure Functions v2 (.NET Core)**

1. Select **Http trigger**

1. Under **Storage Account**, select **Storage Emulator**

1. Under **Access rights**, select **Anonymous**

    > **Note:** The created function can be triggered by any client without providing a key. This authorization setting makes it easy to test your new function. For more information about keys and authorization, see [Authorization keys](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook#authorization-keys) in the [HTTP and webhook bindings](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook).

1. Click **OK**

1. In the **Solution Explorer**, rename the file *Function1.cs* by *HttpTriggeredFunction*

1. A pop-up dialog will request if you would like to perform a rename in this project of all references to the code element 'Function1'? Click **Yes**

    > **Note:** This refactoring will not update the function name in the decoration

1. In the *HttpTriggeredFunction* class, update the function name in the decoration with the class name

    \[FunctionName("HttpTriggeredFunction")]

1. Update the LogInformation message and type the function name

    log.LogInformation("HttpTriggeredFunction from Visual Studio");

1. Add the following instruction after the declaration and assignation of the variable name:

    log.LogInformation($"Request Query: {req.QueryString}");

1. Add the following instruction after the declaration and assignation of the variable *requestBody*:

    log.LogInformation($"Request Body: {requestBody}");

</details>

#### Task 2: Test the HTTP triggered function in local

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, click the **Debug** menu and select **Start Debugging**

1. A console application will open, wait until the URL of the *HttpTriggeredFunction* function is displayed

1. Copy the URL

1. Open **Postman**

1. Under **New Tab**, switch from **GET** to **POST**

1. In the **Enter request URL**, paste the URL copied in the previous step

1. Click **Body**

1. Under **Body**, select **raw**

1. In the **Body** field, type the following request body:

    {<br />"name": "in local from Visual Studio and Postman"<br />}

1. Click **Send**

1. In the bottom pane, check the **Status** code

    A *200 OK* response should be displayed

1. In the bottom pane, check the response

    *Hello, in local from Visual Studio and Postman* should be displayed.

1. Back in the console application, check the logs

    *\[dd/mm/yyyy hh:mm:ss] HttpTriggeredFunction from Visual Studio <br />\[dd/mm/yyyy hh:mm:ss] Request Query:
\[dd/mm/yyyy hh:mm:ss] Request Body: {<br />        name: "in local from Visual Studio and Postman"}*<br />should appear in the logs.

1. In **Visual Studio**, click the **Debug** menu and select **Stop Debugging**

</details>

#### Task 3: Get the publish profile of the Azure Function from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, click **App Services**

1. Select the **Function App** created in the previous lab

1. Click **Get publish profile** and download the **.PublishSettings**

</details>

#### Task 4: Publish an Azure Function from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, update the **AuthorizationLevel** from **Anonymous** to **Function** in the *Run* method of the class *HttpTriggeredFunction*

1. Click the **Build** menu, and select **Publish az203functions**

1. In the **Pick a publish target** dialog, click the **Import Profile...** button

1. Browse and select the **.PublishSettings** downloaded in the previous task

1. Click **Open**

1. Back in the **Publish** dialog, click **Publish**

</details>

#### Task 5: Check the deployment in Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, in the function blade, select the function *HttpTriggeredFunction*

    **Note:** As the function has been deployed from Visual Studio, the code is not editable.

1. Click **Run**

1. Type a new **name** in the **Request Body**

1. Click **Run** and check the **Logs**

</details>