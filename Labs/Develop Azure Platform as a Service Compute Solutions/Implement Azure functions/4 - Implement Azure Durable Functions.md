# Azure Durable Functions

The following labs should be done in Visual Studio 2017.

## Lab 1: Simplify the Chaining pattern

#### Task 1: Create a simple orchestration of three functions calls

<details>
<summary>Click here to display answers</summary>

1. Open **Visual Studio 2017**

1. In **Visual Studio**, select **New** > **Project** from the **File** menu

1. In the **New Project** dialog, expand **Installed**, expand **Visual C#** > **Cloud**, select **Azure Functions**

1. Next to  **Name** type *az203AzureDurableFunctions*

1. Click **OK**

1. In the **New Project - az203AzureDurableFunctions** dialog, select **Azure Function v2 (.NET Core)**

1. Select the **Empty** template

1. Under **Storage Account**, select **Storage Emulator**

1. Click **OK**

1. Right-click the project and select **Add** > **New Azure Function**

1. Select **Azure Function**, next to **Name** type *ChainingPattern*, click **Add**

1. Select the **Durable Function Orchestration** template, click **OK**

1. The template comes with three functions : an Http triggered function, and an Activity triggered function who is called three times in the RunOrchestrator function

1. Click in the menu **Debug**, and select **Start Debugging**

1. Copy the **ChainingPattern_HttpStart** URL

1. Open **Postman**, and trigger the Http function by pasting the **URL**, selecting the **POST** method and clicking **Send**

1. In the console, the log displays the execution of the **ChainingPattern_Hello**

    ...
    Saying hello to Tokyo.
    ...
    Saying hello to Seattle.
    ...
    Saying hello to London.
    ...

1. Click in the menu **Debug**, and select **Stop Debugging**

</details>

#### Task 2: Create a sub-orchestration of two functions and replace the second call in the previous orchestration with the sub-orchestration

> **Note:** [Click here to consult the documentation regarding **Sub-orchestrations in Durable Functions**](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-sub-orchestrations).

<details>
<summary>Click here to display answers</summary>

1. Copy the method **RunOrchestrator** and rename the duplicate by **RunSubOrchestration**

1. In the content of the **RunSubOrchestration** method, call the **ChainingPattern_Hello** twice, one with *Paris* input, and the second with *Seattle* (remove the third call)

    You should have the following code:

    ```csharp
    [FunctionName("RunSubOrchestration")]
    public static async Task<List<string>> RunSubOrchestration(
        [OrchestrationTrigger] DurableOrchestrationContext context)
    {
        var outputs = new List<string>();

        outputs.Add(await context.CallActivityAsync<string>("ChainingPattern_Hello", "Paris"));
        outputs.Add(await context.CallActivityAsync<string>("ChainingPattern_Hello", "Seattle"));

        return outputs;
    }
    ```

1. In the **RunOrchestrator** method, comment the second call to the **ChainingPattern_Hello** function and add the following instruction:

    ```csharp
    await context.CallSubOrchestratorAsync("RunSubOrchestration", null);
    ```

1. Place a breakpoint in the last instruction of the **RunOrchestrator** method

1. Start debugging and trigger the orchestration with Postman

1. Check the **Logs** in the console application

       ...
    Saying hello to Tokyo.
    ...
    Saying hello to Paris.
    ...
    Saying hello to Seattle.
    ...
    Saying hello to London.
    ...

1. When the breakpoint hit, check the value of the *outputs* list

    Paris and Seattle should be missing

1. Stop Debugging

1. In the **RunOrchestrator** method, replace the call to the sub orchestration by the following instruction:

    ```csharp
    List<string> subOrchestrationOutputs = await context.CallSubOrchestratorAsync<List<string>>("RunSubOrchestration", null);
    ```

1. Add the following instruction after the call to the sub orchestration to add the outputs from the sub orchestration to the outputs of the main orchestration

    ```csharp
    outputs.AddRange(subOrchestrationOutputs);
    ```

1. Start debugging and trigger the orchestration with Postman

1. When the breakpoint hit, check the value of the *outputs* list

    All four cities should be in the *outputs* list

1. Stop Debugging

</details>

#### Task 3: Adding two new activity functions Start and End

The function Start should be called in the beginning of the orchestration and log *Start*.
The function End should be called at the end of the orchestration and log *End*.

<details>
<summary>Click here to display answers</summary>

1. Add the following activity functions:

    ```csharp
    [FunctionName("ChainingPattern_Start")]
    public static void Start([ActivityTrigger] object input, ILogger log)
    {
        log.LogWarning($"Start");
    }

    [FunctionName("ChainingPattern_End")]
    public static void End([ActivityTrigger] object input, ILogger log)
    {
        log.LogWarning($"End");
    }
    ```

    > **Note:** Activity functions must have an input object with the attribute ActivityTrigger to make them activty functions.

    > **Information:** The LogWarning method is used as the logs will appear in yellow in the console application. Making them more visible for debug purposes.

1. In the **RunOrchestrator** method, add the following call at the beginning of the method:

    ```csharp
    await context.CallActivityAsync("ChainingPattern_Start", null);
    ```

1. In the **RunOrchestrator** method, add the following call at the end of the method, before the return instruction:

    ```csharp
    await context.CallActivityAsync("ChainingPattern_End", null);
    ```

</details>

#### Task 4: Logging with replays

<details>
<summary>Click here to display answers</summary>

1. Add the following activity function:

    ```csharp
    [FunctionName("LogWarning")]
    public static string LogWarning([ActivityTrigger] string input, ILogger log)
    {
        log.LogWarning(input);
        return input;
    }
    ```

1. Replace the content of the **RunSubOrchestration** method with the following code:

    ```csharp
    var outputs = new List<string>();

    Random random = new Random();
    int randomNumber = random.Next(0, 100);

    outputs.Add(await context.CallActivityAsync<string>("LogWarning", randomNumber.ToString()));
    outputs.Add(await context.CallActivityAsync<string>("LogWarning", randomNumber.ToString()));

    Guid uniqueIdentifier = Guid.NewGuid();

    outputs.Add(await context.CallActivityAsync<string>("LogWarning", uniqueIdentifier.ToString()));
    outputs.Add(await context.CallActivityAsync<string>("LogWarning", uniqueIdentifier.ToString()));

    DateTime currentDate = DateTime.Now;

    outputs.Add(await context.CallActivityAsync<string>("LogWarning", currentDate.ToString()));
    outputs.Add(await context.CallActivityAsync<string>("LogWarning", currentDate.ToString()));

    return outputs;
    ```

1. Add the using statement to resolve the errors

    ```csharp
    using System;
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

    The **Logs** display two different random numbers, Guids and dates.

    > **Warning:** The replay behavior creates constraints on the type of code that can be written in an orchestrator function:
    >
    > Orchestrator code must be deterministic. It will be replayed multiple times and must produce the same result each time. For example, no direct calls to get the current date/time, get random numbers, generate random GUIDs, or call into remote endpoints.
    >
    > If orchestrator code needs to get the current date/time, it should use the CurrentUtcDateTime (.NET) or currentUtcDateTime (JavaScript) API, which is safe for replay.
    >
    > If orchestrator code needs to generate a random GUID, it should use the NewGuid (.NET) API, which is safe for replay, or delegate GUID generation to an activity function (JavaScript).
    >
    >
    > [Click here to cinsult the documentation regarding the **Orchestrator code constraints**](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-checkpointing-and-replay#orchestrator-code-constraints).

1. Stop debugging

1. Add a new class called MinMaxRange with the following properties:

    ```csharp
    public class MinMaxRange
    {
        public int Min;
        public int Max;
    }
    ```

1. Add a new activty function in order to return a safe random number

    ```csharp
    [FunctionName("GenerateRandomNumber")]
    public static int GenerateRandomNumber([ActivityTrigger] MinMaxRange input, ILogger log)
    {
        Random random = new Random();
        int randomNumber = random.Next(input.Min, input.Max);

        return randomNumber;
    }
    ```

1. Add a new activty function in order to return a safe new Guid

    ```csharp
    [FunctionName("GenerateNewGuid")]
    public static Guid GenerateNewGuid([ActivityTrigger] object input, ILogger log)
    {
        return Guid.NewGuid();
    }
    ```

1. Use the new activity functions to replace the non deterministic methods in the **RunSubOrchestration** method:

    ```csharp
    int randomNumber = await context.CallActivityAsync<int>("GenerateRandomNumber", new MinMaxRange { Min = 0, Max = 100 });
    ```

    ```csharp
    Guid uniqueIdentifier = await context.CallActivityAsync<Guid>("GenerateNewGuid", null);
    ```

1. Replace DateTime.Now by context.CurrentUtcDateTime

    ```csharp
    DateTime currentDate = context.CurrentUtcDateTime;
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

    The **Logs** should display the same random numbers, Guids and dates.

1. Stop debugging

</details>

#### Task 5: Handling errors

> **Note:** [Click here to consult the document regarding Errors handling in activity functions](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-error-handling#errors-in-activity-functions).

<details>
<summary>Click here to display answers</summary>

1. Create a new activity function called *RaiseError* which raises an Exception

    ```csharp
    [FunctionName("RaiseError")]
    public static void RaiseError([ActivityTrigger] object input, ILogger log)
    {
        throw new Exception("An error occured for testing purposes.");
    }
    ```

1. Call the *RaiseError* activity function in the main orchestration function before calling the sub orchestration function

    ```csharp
    await context.CallActivityAsync("RaiseError", null);
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

1. Stop debugging when the exception is raised

1. Wrap the activity functions calls with a try/finally block (after the Start function and before the End function).

1. Move the End function in the finally block

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

1. When the exception is raised, check that the End function is called

1. Stop debugging

</details>

#### Task 6: Handling retries

<details>
<summary>Click here to display answers</summary>

> **Note:** [Click here to consult the document regarding Automatic retry on failure](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-error-handling#automatic-retry-on-failure).

1. Replace the call to the *RaiseError* activity function by the following code:

    ```csharp
    var retryOptions = new RetryOptions(
        firstRetryInterval: TimeSpan.FromSeconds(10),
        maxNumberOfAttempts: 3);
    await context.CallActivityWithRetryAsync("RaiseError", retryOptions, null);
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

    The error should be raised three times.

1. Stop debugging

1. Comment the call to the *RaiseError* activity function

</details>

#### Task 7: Handling cancellation

<details>
<summary>Click here to display answers</summary>

1. Start debugging, trigger the orchestration with **Postman**

1. In **Postman**, under **Http Response Body**, click the link next to **terminatePostUri**

1. In the new tab, select **POST** and click **Send**

1. After a 202 response, close the tab

1. In **Postman**, under **Http Response Body**, click the link next to **statusQueryGetUri**

1. In the new tab, click **Send**

1. Check the **Http Response Body**

    It should display 
    
    ```json
    "runtimeStatus": "Terminated",
    ```

1. Check the **Logs**

1. Stop debugging

</details>

## Lab 2: Implement a Fan-out / Fan-in pattern

> **Note:** [Click here to consult the documentation regarding the Fan-out / Fan-in pattern](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-cloud-backup).

#### Task 1: Create a new Azure Durable Functions Orchestration called FanOutFanInPattern

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the project and select **Add** > **New Azure Function...**

1. In the **Add New Item** dialog, select **Azure Function**

1. Next to **Name**, type *FanOutFanInPattern*

1. Click **OK**

1. In the **New Azure Function - FanOutFanInPattern** dialog, select **Durable Functions Orchestration** and click **OK**

</details>

#### Task 2: Replace the LogInformation by LogWarning in FanOutFanInPattern_Hello function

#### Task 3: Create a sub-orchestration taking a list of strings and calling for each string the FanOutFanInPattern_Hello activity function

<details>
<summary>Click here to display answers</summary>

1. Copy the method **RunOrchestrator** and rename the duplicate by **FanOutFanInPattern_SubOrchestration**

1. In the content of the **FanOutFanInPattern_SubOrchestration** method

    You should have the following code:

    ```csharp
    [FunctionName("FanOutFanInPattern_SubOrchestration")]
    public static async Task<List<string>> FanOutFanInPattern_SubOrchestration(
        [OrchestrationTrigger] DurableOrchestrationContext context)
    {
        var outputs = new List<string>();

        outputs.Add(await context.CallActivityAsync<string>("FanOutFanInPattern_Hello", "Tokyo"));
        outputs.Add(await context.CallActivityAsync<string>("FanOutFanInPattern_Hello", "Seattle"));
        outputs.Add(await context.CallActivityAsync<string>("FanOutFanInPattern_Hello", "London"));

        return outputs;
    }
    ```

1. In the beginning of the method, split the input string with a semicolon delimiter into a list of strings

    ```csharp
    string input = context.GetInput<string>();
    var items = input.Split(";");
    ```

1. Replace the three calls with a foreach, and call the **FanOutFanInPattern_Hello** function for each item of the list

    ```csharp
    foreach (string item in items)
        outputs.Add(await context.CallActivityAsync<string>("FanOutFanInPattern_Hello", item));
    ```

1. In the **RunOrchestrator** method, remove the calls to the **FanOutFanInPattern_Hello** function and add the following instructions:

    ```csharp
    await context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "Tokyo;Seattle;London");
    ```

1. Start debugging to test, and trigger the FanOutFanInPattern function with **Postman**

1. Check the **Logs**

1. Stop debugging

</details>

#### Task 4: Add more calls to the suborchestration function

- First call should pass the argument "Start;Start;Start"
- Second call should pass the argument "1a;1b;1c"
- Third call should pass the argument "2a;2b;2c;2d;2e;2f;2g;2h;2i"
- Fourth call should pass the argument "3a"
- Fifth call should pass the argument "End;End;End"

<details>
<summary>Click here to display answers</summary>

1. In the RunOrchestrator method, replace the call by:

    ```csharp
    await context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "Start;Start;Start");

    await context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "1a;1b;1c");
    await context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "2a;2b;2c;2d;2e;2f;2g;2h;2i");
    await context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "3a");

    await context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "End;End;End");
    ```

</details>

#### Task 5: Parallelize the second to fourth calls included

<details>
<summary>Click here to display answers</summary>

1. Create a Task array of length three before the second call

    ```csharp
    var tasks = new Task[3];
    ```

1. Replace the calls with:

    ```csharp
    tasks[0] = context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "1a;1b;1c");
    tasks[1] = context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "2a;2b;2c;2d;2e;2f;2g;2h;2i");
    tasks[2] = context.CallSubOrchestratorAsync("FanOutFanInPattern_SubOrchestration", "3a");
    ```

1. Wait for all tasks after the fourth call and before the fifth call

    ```csharp
    await Task.WhenAll(tasks);
    ```

1. Start debugging to test, and trigger the FanOutFanInPattern function with **Postman**

1. Check the **Logs**

    The call with *3a* should be logged before the completion of the call *2i*. 

1. Stop debugging

</details>

## Lab 3: Waiting for human interaction in an orchestration

#### Task 1: Create a new Azure Durable Functions Orchestration called HumanInteractionPattern

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the project and select **Add** > **New Azure Function...**

1. In the **Add New Item** dialog, select **Azure Function**

1. Next to **Name**, type *HumanInteractionPattern*

1. Click **OK**

1. In the **New Azure Function - HumanInteractionPattern** dialog, select **Durable Functions Orchestration** and click **OK**

</details>

#### Task 2: Replace the LogInformation by LogWarning in HumanInteractionPattern_Hello function

#### Task 3: Wait for an external event called Approval

<details>
<summary>Click here to display answers</summary>

1. In the **RunOrchestrator** method, add the following code before the second call to the **HumanInteractionPattern_Hello** function:

    ```csharp
    string approval = await context.WaitForExternalEvent<string>("Approval");
    ```

</details>

#### Task 4: Add a condition: call the second function if approval is equal to **Approved**, else call the third function

<details>
<summary>Click here to display answers</summary>

1. In the **RunOrchestrator** method, add the following code before the second call to the **HumanInteractionPattern_Hello** function:

    ```csharp
    if(approval == "Approved")
        outputs.Add(await context.CallActivityAsync<string>("HumanInteractionPattern_Hello", "Seattle"));
    else
        outputs.Add(await context.CallActivityAsync<string>("HumanInteractionPattern_Hello", "London"));
    ```

</details>

#### Task 5: Test the human interaction

<details>
<summary>Click here to display answers</summary>

1. Start debugging to test, and trigger the **HumanInteractionPattern** function with **Postman**

1. Check the **Logs**

1. In **Postman**, click the **sendEventPostUri**

1. Replace {eventName} by **Approval**

1. In the new tab, select **POST**

1. Under **Body**, select **raw**

1. Under **Text**, select **JSON (application/json)**

1. Type **"Approved"**

1. Click **Send**

1. Check the **Logs**

    The Logs should display **Saying hello to Seattle.**

1. Trigger the **HumanInteractionPattern** function with **Postman**

1. Check the **Logs**

1. In **Postman**, click the **sendEventPostUri**

1. Replace {eventName} by **Approval**

1. In the new tab, select **POST**

1. Under **Body**, select **raw**

1. Under **Text**, select **JSON (application/json)**

1. Type **"Refused"**

1. Click **Send**

1. Check the **Logs**

    The Logs should display **Saying hello to London.**

1. Stop debugging

</details>

#### Task 6: Add a 90 seconds timeout before Approval and test again

<details>
<summary>Click here to display answers</summary>

1. Replace the WaitForExternalEvent instruction by the following code:

    ```csharp
    string approval = "Undefined";
    using (var timeoutCts = new CancellationTokenSource())
    {
        DateTime expiration = context.CurrentUtcDateTime.AddSeconds(90);
        Task timeoutTask = context.CreateTimer(expiration, timeoutCts.Token);
        Task<string> approvalTask = context.WaitForExternalEvent<string>("Approval");

        var winner = await Task.WhenAny(timeoutTask, approvalTask);
        if (winner == approvalTask)
        {
            approval = approvalTask.Result;
            timeoutCts.Cancel();
        }
        else
            approval = "Timeout";
    }
    ```

1. Start debugging to test, and trigger the **HumanInteractionPattern** function with **Postman**

1. Check the **Logs**

1. In **Postman**, click the **sendEventPostUri**

1. Replace {eventName} by **Approval**

1. In the new tab, select **POST**

1. Under **Body**, select **raw**

1. Under **Text**, select **JSON (application/json)**

1. Type **"Approved"**

1. Click **Send**

1. Check the **Logs**

    The Logs should display **Saying hello to Seattle.**

1. Trigger the **HumanInteractionPattern** function with **Postman**

1. Check the **Logs**

1. In **Postman**, click the **sendEventPostUri**

1. Replace {eventName} by **Approval**

1. In the new tab, select **POST**

1. Under **Body**, select **raw**

1. Under **Text**, select **JSON (application/json)**

1. Type **"Refused"**

1. Click **Send**

1. Check the **Logs**

    The Logs should display **Saying hello to London.**

1. Trigger the **HumanInteractionPattern** function with **Postman**

1. Wait 90 seconds

1. Check the **Logs**

    The Logs should display **Saying hello to London.**

1. Stop debugging

</details>

## Lab 4: Waiting for human interaction in an orchestration with Twilio

> **Note:** [Click here to consult the documentation regarding the human interaction handling with a phone verification](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-phone-verification).

#### Task 1: Create a new Azure Durable Functions Orchestration called SmsInteractionPattern

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the project and select **Add** > **New Azure Function...**

1. In the **Add New Item** dialog, select **Azure Function**

1. Next to **Name**, type *SmsInteractionPattern*

1. Click **OK**

1. In the **New Azure Function - SmsInteractionPattern** dialog, select **Durable Functions Orchestration** and click **OK**

</details>

#### Task 2: Replace the LogInformation by LogWarning in SmsInteractionPattern_Hello function

#### Task 3: Create a free Twilio account and configure the app settings

<details>
<summary>Click here to display answers</summary>

1. Go to [Try Twilio](https://www.twilio.com/try-twilio)

1. Fill the form and click **Get Started**

1. Fill your phone number and validate

1. Get the verification code from the SMS sent by Twilio

1. Input the verification code and confirm

1. Go to [Twilio Test Credentials ](https://www.twilio.com/console/voice/runtime/test-credentials)

1. Copy the **Account SID**

1. In **Visual Studio**, open the local.settings.json

1. Add the setting **TwilioAccountSid** and paste the **Account SID** in the value

1. Go back to **Twilio**, copy the **Auth Token**

1. In **Visual Studio**, in the local.settings.json

1. Add the setting **TwilioAuthToken** and paste the **Auth Token** in the value

1. Add the setting **TwilioPhoneNumber** and type *+15005550006*

</details>

#### Task 4: Send the code by SMS

<details>
<summary>Click here to display answers</summary>

1. Install the **Microsoft.Azure.WebJobs.Extensions.Twilio** Nuget package

1. Add the following using statements:

    ```csharp
    using System;
    using System.Threading;
    #if NETCOREAPP2_1
    using Twilio.Rest.Api.V2010.Account;
    using Twilio.Types;
    #else
    using Twilio;
    #endif
    ```

1. Add the SendSmsChallenge function with the following code:

    ```csharp
    [FunctionName("SendSmsChallenge")]
    public static int SendSmsChallenge(
        [ActivityTrigger] string phoneNumber,
        ILogger log,
        [TwilioSms(AccountSidSetting = "TwilioAccountSid", AuthTokenSetting = "TwilioAuthToken", From = "%TwilioPhoneNumber%")]
#if NETCOREAPP2_1
            out CreateMessageOptions message)
#else
            out SMSMessage message)
#endif
    {
        // Get a random number generator with a random seed (not time-based)
        var rand = new Random(Guid.NewGuid().GetHashCode());
        int challengeCode = rand.Next(10000);

        log.LogWarning($"Sending verification code {challengeCode} to {phoneNumber}.");

#if NETCOREAPP2_1
        message = new CreateMessageOptions(new PhoneNumber(phoneNumber));
#else
        message = new SMSMessage { To = phoneNumber };
#endif
        message.Body = $"Your verification code is {challengeCode:0000}";

        return challengeCode;
    }
    ```

1. Add the SmsPhoneVerification function with the following code: 

    ```csharp
    [FunctionName("SmsPhoneVerification")]
    public static async Task<bool> Run(
        [OrchestrationTrigger] DurableOrchestrationContext context, ILogger log)
    {
        string phoneNumber = context.GetInput<string>();
        bool authorized = false;

        if (string.IsNullOrEmpty(phoneNumber))
        {
            throw new ArgumentNullException(
                nameof(phoneNumber),
                "A phone number input is required.");
        }

        int challengeCode = await context.CallActivityAsync<int>(
            "SendSmsChallenge",
            phoneNumber);

        // TODO: Wait for human interaction

        if(!authorized)
            log.LogError("Not authorized");

        return authorized;
    }
    ```

1. In the **RunOrchestrator** method, add the following code after the first call to the **SmsInteractionPattern_Hello** function:

    ```csharp
    string phoneNumber = "+33xxxxxxxxx";
    bool authorized = await context.CallSubOrchestratorAsync<bool>("SmsPhoneVerification", phoneNumber);
    ```

1. Add the following if statement before the second call to the **SmsInteractionPattern_Hello** function:

    ```csharp
    if(authorized)
        outputs.Add(await context.CallActivityAsync<string>("SmsInteractionPattern_Hello", "Seattle"));
    ```

</details>

#### Task 5: Wait and check the human response

<details>
<summary>Click here to display answers</summary>

1. In the **SmsPhoneVerification** function, replace the *// TODO: Wait for human interaction* with the following code:

    ```csharp
    using (var timeoutCts = new CancellationTokenSource())
    {
        // The user has 90 seconds to respond with the code they received in the SMS message.
        DateTime expiration = context.CurrentUtcDateTime.AddSeconds(90);
        Task timeoutTask = context.CreateTimer(expiration, timeoutCts.Token);

        for (int retryCount = 0; retryCount <= 3; retryCount++)
        {
            Task<int> challengeResponseTask =
                context.WaitForExternalEvent<int>("SmsChallengeResponse");

            Task winner = await Task.WhenAny(challengeResponseTask, timeoutTask);
            if (winner == challengeResponseTask)
            {
                // We got back a response! Compare it to the challenge code.
                if (challengeResponseTask.Result == challengeCode)
                {
                    authorized = true;
                    break;
                }
            }
            else
            {
                // Timeout expired
                break;
            }
        }

        if (!timeoutTask.IsCompleted)
        {
            // All pending timers must be complete or canceled before the function exits.
            timeoutCts.Cancel();
        }
    }
    ``` 

1. Start debugging to test, and trigger the SmsInteractionPattern function with **Postman**

1. Check the **Logs**

1. In **Postman**, click the **sendEventPostUri**

1. Replace {eventName} by **SmsChallengeResponse**

1. In the new tab, select **POST**

1. Under **Body**, select **raw**

1. Under **Text**, select **JSON (application/json)**

1. Type the verification code

1. Click **Send**

1. Stop debugging

</details>

## Lab 5: Running Eternal orchestrations

> **Note:** [Click here to consult the documentation regarding **Eternal orchestrations**](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-eternal-orchestrations).

#### Task 1: Create a new Azure Durable Functions Orchestration called EternalOrchestration

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the project and select **Add** > **New Azure Function...**

1. In the **Add New Item** dialog, select **Azure Function**

1. Next to **Name**, type *EternalOrchestration*

1. Click **OK**

1. In the **New Azure Function - EternalOrchestration** dialog, select **Durable Functions Orchestration** and click **OK**

</details>

#### Task 2: Read number in the EternalOrchestration_HttpStart function and pass it to the EternalOrchestration function

<details>
<summary>Click here to display answers</summary>

1. Add the following code in the beginning of the **EternalOrchestration_HttpStart** method:

    ```csharp
    var content = req.Content;
    string inputString = await content.ReadAsStringAsync();
    int inputNumber = 0;
    int.TryParse(inputString, out inputNumber);
    ```

1. Pass the inputNumber variable in the call to the **EternalOrchestration** function

    ```csharp
    string instanceId = await starter.StartNewAsync("EternalOrchestration", inputNumber);
    ```

</details>

#### Task 3: Replace the LogInformation by LogWarning in EternalOrchestration_Hello function

#### Task 4: Log the input number in the RunOrchestrator function

<details>
<summary>Click here to display answers</summary>

1. Replace the **RunOrchestrator** method with the following code:

    ```csharp
    public static async Task RunOrchestrator(
        [OrchestrationTrigger] DurableOrchestrationContext context, ILogger logger)
    {
        int inputNumber = context.GetInput<int>();
        if(!context.IsReplaying)
            logger.LogWarning(inputNumber.ToString());

        await context.CallActivityAsync<string>("EternalOrchestration_Hello", "Tokyo");
        await context.CallActivityAsync<string>("EternalOrchestration_Hello", "Seattle");
        await context.CallActivityAsync<string>("EternalOrchestration_Hello", "London");
    }
    ```

1. Start debugging to test and copy the URL of the **EternalOrchestration** function

1. In **Postman**, paste the **URL** and select **POST**

1. Click **Body** select **raw** and under **Text** select **JSON (application/json)**

1. Type *10*

1. Click **Send**

1. In Azure Functions console, check the **Logs**

1. Stop debugging

</details>

#### Task 5: Resetting the orchestration history and pass (inputNumber + 1) to the next orchestration if the inputNumber is less than 50, and with a 15 seconds delay between each run

<details>
<summary>Click here to display answers</summary>

1. Add the following code at the end of the **RunOrchestrator** method in order to wait 15 seconds before ending the run:

    ```csharp
    var nextRun = context.CurrentUtcDateTime.AddSeconds(15);
    await context.CreateTimer(nextRun, CancellationToken.None);
    ```

1. Resolve the error by adding the following using statement:

    ```csharp
    using System.Threading;
    ```

1. Add the following code at the end of the **RunOrchestrator** method in order to reset the orchestration function:

    ```csharp
    if(inputNumber < 50)
        context.ContinueAsNew(inputNumber + 1);
    ```

1. Start debugging to test and copy the URL of the **EternalOrchestration** function

1. In **Postman**, paste the **URL** and select **POST**

1. Click **Body** select **raw** and under **Text** select **JSON (application/json)**

1. Type *10*

1. Click **Send**

1. In Azure Functions console, check the **Logs**

1. Wait 15 seconds and check the **Logs** again

1. Wait 15 seconds and check the **Logs** again

1. Wait 15 seconds and check the **Logs** again

1. Stop debugging

</details>

#### Task 6: Terminate the eternal orchestration

<details>
<summary>Click here to display answers</summary>

1. Start debugging

1. Check the **Logs**

    The eternal orchestration should keep running.

1. In **Postman**, click the **terminatePostUri** link

1. In the new tab, select **POST**

1. Click **Body** select **raw** and under **Text** select **JSON (application/json)**

1. Click **Send**

    > **Warning!** If the orchestration is not terminated, stop debugging, remove the ContinueAsNew instruction and start debugging again.
    The termination might not work locally in Azure function simulator.
    The 50 limit has been set in case, if redeploying the function doesn't work.

1. Stop debugging

</details>

## Lab 6: Replace a timer trigger with the Monitor pattern

- Monitors run on intervals, not schedules: a timer trigger runs every hour; a monitor waits one hour between actions. A monitor's actions will not overlap unless specified, which can be important for long-running tasks.
- Monitors can have dynamic intervals: the wait time can change based on some condition.
- Monitors can terminate when some condition is met or be terminated by another process.
- Monitors can take parameters. The sample shows how the same weather-monitoring process can be applied to any requested location and phone number.
- Monitors are scalable. Because each monitor is an orchestration instance, multiple monitors can be created without having to create new functions or define more code.
- Monitors integrate easily into larger workflows. A monitor can be one section of a more complex orchestration function, or a sub-orchestration.

> **Note:** [Click here to consult the tutorial regarding the **Monitor pattern**](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-monitor).

In this lab, we would like to create a **Monitor** checking our **Balance**:
- If the **Balance** is greater than 100, log an **Information**, then wait 60 seconds before the next monitoring
- If the **Balance** is between 0 and 100, log an **Warning**, then wait 30 seconds before the next monitoring
- If the **Balance** is less than 0, log an **Error**, then wait 10 seconds before the next monitoring
- Terminate the **Monitor** after 5 minutes

In real-life, SMS can be sent to alert the person of his/her **Balance** with longer delays for each situation.

#### Task 1: Create a new Azure Durable Functions Orchestration called MonitorPattern

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, right-click the project and select **Add** > **New Azure Function...**

1. In the **Add New Item** dialog, select **Azure Function**

1. Next to **Name**, type *MonitorPattern*

1. Click **OK**

1. In the **New Azure Function - MonitorPattern** dialog, select **Durable Functions Orchestration** and click **OK**

</details>

#### Task 2: Create an Azure Table Storage called Balances with two columns UserName and Balance

<details>
<summary>Click here to display answers</summary>

1. Open **Microsoft Azure Storage Explorer**, expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Tables** and click **Create Table**

1. Type **Balances**

</details>

#### Task 3: Add the following entities in the created table

| PartitionKey | RowKey | UserName | Balance |
| ------------ | ------ | -------- | ------- |
| Paris        | Alpha  | Alpha    | 150     |
| Tokyo        | Beta   | Beta     | 50      |
| Seattle      | Delta  | Delta    | 0       |
| London       | Gamma  | Gamma    | -50     |
| Paris        | Omega  | Omega    | -100    |

<br />

<details>
<summary>Click here to display answers</summary>

1. Click **Add**

1. In the **Microsoft Azure Storage Explorer - Add Entity** dialog, click **Add Property** twice

1. Fill as following:

    | Property Name | Type   | Value |
    | ------------- | ------ | ----- |
    | PartitionKey  | String | Paris |
    | RowKey        | String | Alpha |
    | UserName      | String | Alpha |
    | Balance       | Int32  | 200   |

1. Click **Insert**

1. Repeat the same steps to add the remaining entities

</details>

#### Task 4: Add new activity function called MonitorPattern_GetBalance and read the Balance from the table Balances for a given UserName and Location

<details>
<summary>Click here to display answers</summary>

1. Add a new class called **BalanceRequest** with the properties **Location** and **Balance**

    ```csharp
    public class BalanceRequest
    {
        public string Location { get; set; }
        public string UserName { get; set; }
    }
    ```

1. Add a new class called **BalanceEntity** deriving from **TableEntity** with the properties **UserName** and **Balance**

    ```csharp
    public class BalanceEntity : TableEntity
    {
        public string UserName { get; set; }
        public int Balance { get; set; }
    }
    ```

1. In the **BalanceEntity** class, add the following using statement:

    ```csharp
    using Microsoft.WindowsAzure.Storage.Table;
    ```

1. In **Azure Storage Explorer**, select **Emulator - Default Ports (Key)** and copy the **Primary Connection String** 

1. Open the **local.settings.json** file, add a new setting called **TableConnectionString** and paste the **Primary Connection String** as the value

1. In the **MonitorPattern** class, add the following using statements:

    ```csharp
    using System;
    using System.Threading;
    using Microsoft.WindowsAzure.Storage;
    using Microsoft.WindowsAzure.Storage.Table;
    ```

1. In the **MonitorPattern** class, add the **MonitorPattern_GetBalance** function with the following code:

    ```csharp
    [FunctionName("MonitorPattern_GetBalance")]
    public static async Task<int> MonitorPattern_GetBalance([ActivityTrigger] BalanceRequest balanceRequest, ILogger log)
    {
        string tableConnectionString = Environment.GetEnvironmentVariable("TableConnectionString", EnvironmentVariableTarget.Process);
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(tableConnectionString);
        CloudTableClient client = storageAccount.CreateCloudTableClient();
        CloudTable table = client.GetTableReference("Balances");
        await table.CreateIfNotExistsAsync();
        TableOperation operation = TableOperation.Retrieve<BalanceEntity>(balanceRequest.Location, balanceRequest.UserName);
        TableResult tableResult = await table.ExecuteAsync(operation);

        var entity = (BalanceEntity)tableResult.Result;
        if (entity != null)
        {
            return entity.Balance;
        }
        else
        {
            throw new Exception($"User {balanceRequest.UserName} doesn't exist in {balanceRequest.Location}.");
        }
    }
    ```

1. Replace the **RunOrchestrator** method with the following code in order to call the **MonitorPattern_GetBalance** activity function:

    ```csharp
        public static async Task RunOrchestrator(
            [OrchestrationTrigger] DurableOrchestrationContext context, ILogger log)
        {
            BalanceRequest balanceRequest = new BalanceRequest 
            { 
                Location = "Paris", 
                UserName = "Alpha" 
            };

            int balance = await context.CallActivityAsync<int>("MonitorPattern_GetBalance", balanceRequest);
            log.LogCritical($"Balance is {balance} for user {balanceRequest.UserName}");
        }
    ```

1. Start debugging to test, and trigger the **MonitorPattern** function with **Postman**

1. Check the **Logs**

1. Stop debugging

</details>

#### Task 4: Create the Monitor loop terminating after 10 minutes and checking the balance every minute

<details>
<summary>Click here to display answers</summary>

1. After the assignation of the balanceRequest variable, add the following code:

    ```csharp
    DateTime endTime = monitorContext.CurrentUtcDateTime.AddMinutes(10);
    ```

1. Wrap the call to the **MonitorPattern_GetBalance** activity function and the log in a while loop

    ```csharp
    while (context.CurrentUtcDateTime < endTime)
    {
        int balance = await context.CallActivityAsync<int>("MonitorPattern_GetBalance", balanceRequest);
        if(!context.IsReplaying)
            log.LogCritical($"Balance is {balance} for user {balanceRequest.UserName}");
    }
    ```

1. In the end of the while loop, wait 60 seconds by adding the following code:

    ```csharp
    var nextCheckpoint = context.CurrentUtcDateTime.AddSeconds(60);
    ```

1. In the end of the while loop, wait 60 seconds by adding the following code:

    ```csharp
    await context.CreateTimer(nextCheckpoint, CancellationToken.None);
    ```

1. Start debugging to test, and trigger the **MonitorPattern** function with **Postman**

1. Check the **Logs**

1. In **Postman**, click the **terminatePostUri**, select **POST** and click **Send**

1. Stop debugging

</details>

#### Task 5: Add three activity functions to get the status of each condition and update the nextCheckpoint timer accordingly

<details>
<summary>Click here to display answers</summary>

1. Create an activity function called **MonitorPattern_IsClear** with the following code:

    ```csharp
    [FunctionName("MonitorPattern_IsClear")]
    public static async Task<bool> MonitorPattern_IsClear([ActivityTrigger] int balance, ILogger log)
    {
        if (balance > 100)
        {
            log.LogInformation("Balance is clear.");
            return true;
        }
        else
            return false;
    }
    ```

1. Create an activity function called **MonitorPattern_IsWarning** with the following code:

    ```csharp
    [FunctionName("MonitorPattern_IsWarning")]
    public static async Task<bool> MonitorPattern_IsWarning([ActivityTrigger] int balance, ILogger log)
    {
        if (0 <= balance && balance <= 100)
        {
            log.LogWarning("Balance is low!");
            return true;
        }
        else
            return false;
    }
    ```

1. Create an activity function called **MonitorPattern_IsAlert** with the following code:

    ```csharp
    public static async Task<bool> MonitorPattern_IsAlert([ActivityTrigger] int balance, ILogger log)
    {
        if (balance < 0)
        {
            log.LogError("Balance is negative!!!");
            return true;
        }
        else
            return false;
    }
    ```

1. In the **RunOrchestrator**, add the following code before the timer creation:

    ```csharp
    if(await context.CallActivityAsync<bool>("MonitorPattern_IsClear", balance))
        nextCheckpoint = context.CurrentUtcDateTime.AddSeconds(60);

    if (await context.CallActivityAsync<bool>("MonitorPattern_IsWarning", balance))
        nextCheckpoint = context.CurrentUtcDateTime.AddSeconds(30);

    if (await context.CallActivityAsync<bool>("MonitorPattern_IsAlert", balance))
        nextCheckpoint = context.CurrentUtcDateTime.AddSeconds(10);
    ```

1. Start debugging to test, and trigger the **MonitorPattern** function with **Postman**

1. Check the **Logs**

1. After two **"Balance is clear."** logs, go to **Microsoft Azure Storage Explorer**, select the **Balances** table, select **Alpha** row, click **Edit**, change the **Balance** to *50* and click **Update**

1. Check the **Logs**

1. After two **"Balance is low!"** logs, go to **Microsoft Azure Storage Explorer**, select the **Balances** table, select **Alpha** row, click **Edit**, change the **Balance** to *-50* and click **Update**

1. Check the **Logs**

1. After two **"Balance is negative!!!"** logs, go to **Microsoft Azure Storage Explorer**, select the **Balances** table, select **Alpha** row, click **Edit**, change the **Balance** to *50* and click **Update**

1. Check the **Logs**

1. After two **"Balance is low!"** logs, go to **Postman**, click the **terminatePostUri**, select **POST** and click **Send**

1. Stop debugging

</details>

## Lab 7: Dealing with breaking changes when deploying a new version

> **Note:** [Click here to consult the document regarding the mitigation strategies for dealing with versioning challenges](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-versioning#mitigation-strategies).

#### Task 1: Do nothing

*This approach has been used in Lab 5 to terminate an Eternal orchestration.*

#### Task 2: Stop all in-flight instances by clearing the contents of the internal control-queue and workitem-queue queues

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Side-by-side deployments with deployment slots and the Task Hub

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>