### introduction-to-devsecops-for-managers-lfs180

### 1. INTRODUCTION

### 2. DEVSECOPS BACKGROUND AND HISTORICAL PERSPECTIVE


### 3. TECH LIKE I'M 10 - - Lectured by: Robert Slaughter and Cody

    - Overview and Learning Obective
    - The Basics
    - The Cloud
    - Environment and Pipelines
    - Deployment and Authorizations
    - Vms, Microservices, Container and Kubernetes
    - Cybersecurity Technology
    - Review
    - Knowledge Check


  ## Cloud
    1) Private vs Public Cloud
  ## Cloud Provider:

   A Cloud Provider is a company thet owns a lot computers abd rent them out as a service.
   - i.e Cloud Providers buy, maintain and operate computers
   - Analogy: Cloud is a utility provider (like a electrical company) bit for computers.

   Famous Cloud Providers in the market are AWS, GCP, AZURE

  ## Cloud Services(MANAGED SERVICES)
    - A Cloud Service performs a job for you in the cloud.

    1) Compute
    2) Storage
    3) Database
    4) Security
    5) Authentication

   ## As a Service

    1) On-Premise
    2) Infrastructure as a service
    3) Platform as a service
    4) Software as a service

    Keycomponents:
    1) Applications
    2) DATA
    3) Runtime
    4) Middleware
    5) O/S
    6) Virtualization
    7) Servers
    8) Storage
    9) Networking

    - On Prem (1-9 You Manage) 
    - Iaas (6-9 You Manage)
    - Paas (3-9 You Manage)
    - SaaS (1 -9 Others Manage)


    In a Pyramid structure, SASS sits on the top, then PAAS and then IAAS

    - SAAS - End users
    - PAAS - Application Developers
    - IAAS - Network Arhitecture

    - Network engineers use to build and maintain netoworks

    ## Review:
    1) PaaS manages everything in a tech stack except for data and applications?

        True
    2) A Private Cloud is some else's infrastructure?
        False

        - A Private Cloud is generally a organization running their own infrastructre as a service for their own purposes and development teams.

    3) All cloud manage services are identical across cloud providers?
    False. Although many clouf providers offer similar services, most manage services are slightly different provider to provider.


    #### Environment and Pipelines

    What is an Environment?

    Environemnt is really a landing spot where you run your code or run your software artifacts .

    # Stages
      - Development
      - Testing/Staging
      - Production
    OPs piece is the production environment of which your IT operators are traditionally maintaing.

    Lot of time you will see different toolset in the different environment.

    For example, you may have test tools in your testing/staging environments that you don't need running in production to do operations. 

     
    Tools vary for different env due to Licensing Cost, most likely and also just unnecessary for your computing store

    - Licensing cost
    - Computing store


   ## Source Control Management

   Practice of tracking and managing code changes
   - Running history to help resolve conflicts from multiple resources.

   ## CI Pipelines
   - Plan->Code->Build->Test->Release->Depoy->Operate->Monitor->PLan

   https://software.af.mil/dsop/documents/

   - Developer->Build => Continuous Build
   - Developer->Build->Test => Continuous Integration
   - PLan->Developer->Build->Test->Release&Deiver => Continuous Delivery
   - PLan->Developer->Build->Test->Release&Deiver->Deploy => Continuous Deployment
   - PLan->Developer->Build->Test->Release&Deiver->Deploy->OPerate => Continuous OPerations

   ## Review
    1) For a pipeline to be considered "Continuous" it must be 100% automated?

      False. Although the goal is to automate as much as reasonable, this does not mean that the process will be 100% automated nor that it necessarily shoud be.

    2) CD can mean either continuous delivery or continuous deployment?
       True. 
    3) Is it ok to test in Prod?
        False. (Unless small batch size for user testing). But the vast maority of your test use cases need to be shifted left your unit testing, your integration testing, your end to end testing, your hardware-in-the-loop testing.

    ### Deployment and Authorizations

    Whats is Imperative and Declarative states?

    - A declartive state is something that you fully represent and declare typically in the code base.
    - An imperative state is something that you manually go into and configure.

    So, sort of give you an example of, how you know then you have a system that's fully declarative versus something that's imperative, is if you have your ITb admins or your software engineers interfacing through a CLI in order to customly set up and configure the system.

    The reason why declarative state is so important is that when you set up things in an imperative way, really only the person who set them up and configured them truely understand and know what the system is.

    NOTE: The only way to fully test the production system is to fully represent the production system in your testing or staging environments.

    So if it's not done in a declarative way, you are actually testing with a system thet actually doesn't represent it's true form in production.

    ## Why IaC/CaC - A declarative state

    ## Software layers -Each may have their own ATO
       - Software
       - Platform
       - Infrastructure

    ## Mutable vs Immutable

      - Mutable   => Changable
      - Immutable => Non Changable

    Simple question: Is your baseline declarative? Is it immutable? If yes, then cheaper to sustain.

    ## GitOps
    GitOps approach is continuously delivering and deploying your declarative baseline through a representation of, effectively, source code management and changes.

    ## ATO (Authorization to Operate)
    ATO is essentially your permission to run that software, whether it is infrastructure or platform layer or application layer software in production on an information system, if you will.

    It's really a NIS standard, so it's highly regulatory environemnts where this going to be very common. These are your
      - Healthcare system
      - Financial system
      - Federal goverment system

      All of them put your own tweaks onto it.
     
     But all your ATOs come from a designated approval authority, upon which they're ensuring that you match your compliance to the expected standard.

    ## C-ATO (Continuous ATO)
    Which is your continuoud ATO, which is that software never ends. And so this concept of an approval to deploy or releaase software is very outdated.

    Because the known reality is that there are constantly evolving threats and known isseus and vulnerabilities with in the software baseline. And so it's not sut software is safe, go and, proceed, and do good things.

    It's how you continuously monitor, log, alert and secure the system, or actively definely the system within  an environment of great importnace.

    And so that's where the term of C-ATO comes from, as mentioned, depending on really your background and what systems that yoy're working on, this concept of C-ATO might take different flavours.

    E.g 

    Given our own background, we come from Department of Defense, and so what we see within the Department of Defense is better focus on real security to kind of put it **blunty**, versus **compliance**. 
    
    You should be compliant, however the bureaucracy that slows the ability to become compliant many times induces more security risks. And so if the intent is more secure system, then there has to be ways to accelerate  the new devlivey of software updates, the new delivery of systems, because by delaying those systems you're actually making them less - not more - secure.

    So, it's important to be in compliance, but the most important thing is thet your system is secure.

    ## Review

    1) The main reason to use declarative deployments is to reduc the human error from manually configuring every time?

    Trick Question. Although this is not wrong. The benefit is to capture the desired state so that deployments are automated and therefore not prone to human error while executing. Additonally the current state can continuously compared to the desired state and fixed using automated tools.
    
    Although that is a benefit, i would argue, portantially that the repeatable baselines is potentially the main reason.

    2) Having a C-ATO means you don't need to get approval to deploy a new applications?

    **False**. New applications still need to get  a Certificate to Field(CtF) before initial deployemnt. This is to verify the security aspects of the application are sound. The C-ATO grant permission to continuously deliver updates and features without going through the months-long process that it normally takes to get an ATO.


    With the C-ATO effectively what you're doing is you're accreding the process upon which software expectations and complaince are mapped to your CI/CD pipeline.

    So that you have continuous approval to field within taht system. So Yes, still you need the ATO, but you've backed in the security requirement into your CI/CD framework, upon which you have the ability to continuously update.

    3) IaC and CaC are same thing.

    **False**. IaC really centered on your infrastrucure layers and CaC is centered on your platform layers and how your software application interface with those platform layers.

    4) Software environments should strive to be BOTH declarative and an immutable?

    **False**. We want to make sure that we are not inadvertently creating **deltas** between the baselines and our environments.

   5) Your system is fully secure when it gets its ATO?
    
    **False**. Security is never 100%. The point of compliance is to increase your security posture. The most important thing is that security posture. And ust because you have received an ATO doesn't mean that your system is fully secured.

    That is a continuous process that always has to be updated, always needs to be patched.

    And an entire team needs to be on a lookout on how to continuously better secure, because there is no such thing as perfect security in environemnt.

   6) IaC and CaC are code scripts that run the same steps every time to ensure that environemtns are setup the same way every time.

   **False**. This would be an imperative approach that could ensure consistent results but would miss the other beneficial aspects of using declarative deployments.




   ### VM's, Microservices, Containers and Kubernetes

   ## Why Virtual Machines (VMs)?

   Virtual machines has the ability to run essentially multiple things. Multiple operating system on a single set of hardware.

   So, if you had an application that was Linux-based versus one that is RHEL-based, you could run those without having dedicated hardware for each seperate "thing".

   So. virtual machines virtualize and abstract the infrastructure to allow you to run multiple operating systems on the same infrastructure.

   Prior to virtual machines it was dedicated infrastructure, dedicated operating systems, which makes things in many ways more complex.

   Which is why the community continued to innovate and come out with newer and newer technologies, other than VMs, to make developer's lives easier.

   -------------
   |    VM1    |
   -------------
   | APP 1     |
   | Bins/libs |
   | Guest OS  |
   ------------

    --------------------------------
    |        Hypervisor             |
    --------------------------------
    --------------------------------
    |       Physical Server         |
    --------------------------------

This naturally gave way to containers.

## Why Container?

- Why containers are and why containers came into existence?

  Instead of every application having to bring its own os, you move to container where, though the use of something like Docker, you can run a single os on top of your hypervisor and then each of the applications or services doesn't need have to bring that.

  It's really because of, instead of bringing the OS within your virtualized env, you are abstracting it through some type of container engine.


   -------------
   | Containers|
   -------------
   | APP 1     |
   | Bins/libs |
   ------------
    --------------------------------
    |        Docker Engine         | 
    --------------------------------
    --------------------------------
    | Operating System (Host OS)   |
    --------------------------------
    --------------------------------
    |   Physical Server or VM       |
    --------------------------------

   Whcih brings us natuarally to the next technology that we'd like to discuss, which is microservices.

   ## Why Microservices?

   Broken into seperate services. So now that if you have to update one of those sevices, it is more well defined through APIs, less interdependent monolithiic that you can update that, and also break into smaller chunks.

   Monolithick:
   - Diametrically opposite to microservices
   - Single bundled application that has everything built within there.
   - Very difficult to test.
   - Very long and hard to build
   - especially when you are taking many developers all working off the sams systems, it really ust overll slows down your flow of software delivery.


   ## What is Container "Hardening"?

   Make a container more cyber-secure by reducing the "attack-vector".
   - Control access and flow of information or data between contianer and the underlying IaaS.

   ## Contianer Registry

   - Essentially a single source of contianer images.
   - A place where you store your images, with a ruleset that you can control, you can access, you can monitor 

   ## What problem Kubernetes Solves?

    - Solving contianer orchestration problem
    - Scale up
    - Scale down
    - Auto heal
    - Automates and Abstract away your infrastructure management

   ## Review

   1. In general, contianers are smalle and can spin up or down faster than Virtual Machines?

   **True**. Because contianers rely on host OS and dont't have to bring their own, they are smaller and faster to spin up than VMs.

   2. Kubernetes solves all your problems?

   **False**. Kubernetes has major market adoption, and much of the software ecosystem is being built arount it.

   3. If you need to create an application to be widely distributed to many locations, there are many benefits to look at a containerazied application first.

   **True**. Think back to the problems that contianers solve, that sort of works on ly machine but not your machine type situation. If you have widely distribute an application and you know that you need it to be lightweight, interfacing with a lot of infra types.

### Cybersecurity technology

- Vulnerabilities 
- 

## Network Security

## What is a Service Mesh?

## What is Zero-Trust?

- There is no inherited authentication

## Software Bill of Materials (SBOM)

## Continuous Runtime Monitoring

## Continuous Logging

## Alerting

## Review
1. It is possibly to have a totally secure system?

**False**. Nobody can ever be fully 100% secure, which is why cybersecurity is really about just getting better and better and better.

2. Once inside a network, you should trust everyone?

**False**. W.r.t Zero trust Concept. You wan to provide, whereever possible, least privilege .

And at the same time you are going to have business needs around sharing information.

3. Your SBOM needs to represent the actual system being deployed.

**True**. Absolutely. And so having an Excel Spreadsheeet of what softwware your'e delivering that doesn't actually represent the software that you're delivering is not only pointless, but actually negative value because it's giving you a false sense of security that you don't actually have.

And so sometimes, putting the software that you're using in an Excel spreadhseet might make sense.
ust make sure that the versions and actually what you're deploying is in fact actually what you're delivering to a system.

## Review
1. Don't be afraid of new terms like DevOps, DevSecOps, SBOM. Because everyday the new terms get evolve.
2. Test your own understanding what these terms mean really are.  => Buzzword territory in to mutual understanding terrirtory.
3. Feature complete intorduction to  terms. I think it would be impossible to so such a thing, nor would it be possible to sustain such a thing. Meaning that new terms coming in the env every isngle day. It's important to not only not be afraid of new terms but to go out and on your own, try to figure out what these new terms mean, try to understand why they existed, the historical context, and then understand what problems they are solving. And then test your own undrstanding by explaining it to other people and in doing so, realize where your limits of understanding what these terms really are.

### 4. VALUE STREAM MANAGEMENT - Lectured by: Bryan-Finster and Robert Slaughter

    - Introduction (Duration: 11:07 mins)
    - Mapping Value Streams (Duration: 15:01 mins)
    - Improving Team Value Streams (Duration: 17:10 mins)
    - Improving Org Value Streams (Duration: 20:15 mins)

### Part 1: Introduction

  ## DevOps Three Ways
    - Systems Thinking
    - Amplify and Shorten Feedback Loop
    - Continuous Improvement

    DevOps: improving the flow of value delivery.
  ## Defining Value

  **Value = Impact - Total Cost of Ownership**
    - **Impact**: How much it contribute to the overall goals.
    - **TCO**: Cost to build, maintain and operate.

   Reducing waste reduces cost and improves the value delivered.
   Faster feedback allows faster improvement of devlivered value.

   - Definition of what is most valuable to an organization is really everybody's North Start day to day.

   If we can reduce the cost to build, maintain, and operate, we can increase the value of that, of what we're doing.


   ## Value Stream Management - Idea->Design->Deliver->Operate->Idea

   The disciplined process of reducing waste and improving flow to better deliver value to end-user and accelerate feedback

       --------------EnddUsers <-----------  
       |                                   |
        -->Idea->Design->Deliver->Operate---

    Value Stream is not only the development portion, it's everything from idea, design, implementation, operation, getting that feedback through the people you're delivering that value to.

    It could be sales and marketing. It's whatever it takes to deliver that value is your value stream. And so what we're trying to do with value stream mangement is optimize the value stream, instead of optimizing around fucntional silos.

    Examples:
    An organization locally optimized for what they call developer productivity, by removing any sort of business engagement or testing or support from the development team. And they locally optimized for coding, but that made quality decrease.

    And so it actually increased the cost of, you know, reduced the value, because it increased the total cost of ownership.

    ## Value Flywheel

    Amplify Feedback
    Reduced Cost->Smaller batches->Expose & Reduce Waste->Reduce Waste

    ## Knowledge Check

    1) You don't need value stream managemnt of you have DevOps?

    **False**: DevOps from its begining was focussed on improving value streams.

    2) The goal of value stream management is to reorganise for improved flow?

    **True**: Improving flow improves our ability to acheive our organizational goals and meet the needs of end-user.

    Note: You probably have functional silos within your organizations. And so there's going to be some organizational changes generallly that have to be made. This is not ust about technology.

    3) Value Stream management is focussed on improving how developers deliver software.

    **False**: To improve the flow of product devlivery, we must optimize the entire system.
    
    How developers deliver software is important to value stream management, but i see vsm as connecting entire organization. So it could be your acquisitions team or your business team. It includes your developers, but the develpers are ust one of many.

    - Value stream map:  From a Value Stream Architect
     It took about five days to develop something but it took, 30 days to figure out what to develop and another 45 days to deliver it. But they were only focussing on the development portion.

### Part 2: Mapping Value Streams

    It makes clear for the organization where to focus in order to improve outcomes and outputs, and ultimately increase value.

  ## What is a Value Stream Map?

  A visual representation of the flow of work to identify and prioritize flow improvements.

  ## Value Stream Map Elements
    

   -----------     --------------         |-----------------------|
    Developer  --> Team Member       --> |  Team Member          |
                                         |                       |
    Coding           Code Review         |   Code Review / Merge |
                                         |                       |
----------------   ------------------    -----------------------|
  % C/A: |  PT         %CA  |  PT        |      %CA    |   PT    |
    50%  |  8hr             | 0.5 Hr     |             |  0.5 Hr |
-----------------  -------------------    -------------------------

        8                    0.5                      0.5
----------------|  8  |--------------|  3  |------------------------|   0    
                |-----|              |-----|                        |-------

    There is a term called "Cycle time" mentioned a lot, it is the time it takes for each one of these blue boxes to happen in its entirely.

    There are two elements of cycle time.
    - PT (Process Time) => Time Spent performing step
    - Percent Complete and Accurate
    - WT (Wait Time) => The time work waits between steps
    - Who/What is doing the work
    - Step Name
    Others:
    - Exception Flow
    - Retry Loop
    - Kaizen Improvement Item

  ## Value Stream Flow Efficiency

  **Flow Efficiency = Value Time / Total Time * 100**

  Total Value: 12.17 Hr    => Total PT
  ----------------------
  Total Non value: 139 Hr  => Total WT

  **Flow Efficiency = 8.05%**

  ## Knowledge Check
  1) A value stream map is a process diagram of steps that we need to perform?
  **False**:  It is a visual representation of waste and flow in a system of value delivery.
  
  It's not a process diagram, it's a visual representation of the flow and you are really just trying to capture what the existing process is versus use it as a process diagram.

  2) Before starting any improvement, we need to make sure we measure the current process?

    **True**: Unless we know the current state of the vlaaue stream and where the dependent constrains are, we will not able to effectively improve the outcomes or validate that any improvements are real.

    You don't need an exact measurement all the time, but if you are going to make an impovement, you need to have an understanding over what the existing process is, so that way you can have a great understanding of if you're actually improving it or not.

### Part 3: Improving Team Value Streams

   ### Finding Constraint
      - Re-work waste
    
   ## Eliminate then Automate
      - Remove steps thaat do not add value
      - Automate all the rules

      For the above scenario, we can acheive via following steps,
       1. Move the Constraint to development
       2. Find ways to improve that constaint

   ## Knowledge Check
    1) The main issue impacting most team value streams is poor coding practices.

   **False**: Wait times caused by heavy manual process, poor teamwork, and poor communication are the main issues.
    
    2) We should automate all of the manual processes in the value stream?

   **False**:  Not all steps can be automated. We should eliminate steps that do not add value, automate steps that are based on rules, and collaborate on steps that require creativity.

   3) Our goal is to make coding the main constraint and to systematically improve that contraint?
    
    I'll answer with this caveat.

    **True**: The flow of information into the coding process and the validation and delivery of complete work into production should not constrain the flow of work.

    Any constraints upstream or downstream are going to impact development. So, if it's upstream, development is going to be under utilized where they're just begging for things to do.

    And if it's downstream, we are going to start growing batch size because development will start adding that we are not delivering. And that's just inventory waste that we have to clear.

    And of course, make sure we have good ideas instead of ust stuff we're doing.

    4) Manual validations that cannot be automated should run in parallel to the flow of delivery?
    **True**:  Usability testing, exploratory testing, penetration testing etc., should be done continuosly and not as an acceptance stage to delivery.



### Part 4: Improving org Value Streams

   ## Knowledge Check
   1) Every handoff reduces flow and increases risk?
   **True**: Risks increases that delivery will be delayed, and the reduced flow increaes batch sizes which created additonal risks.

   2)  To immprove the organizational flow, the other team needs to work faster?
   **False**: The external hard dependencies need to be moved in to the team or implemented through platform tooling.

   3) Review by the Security and Compliance teams are critical for safe delivery?
   **False**: Reviewing security and compliance after work is complete increases risk by increasing the delivered batch and increase the chances that critical issues will be missed that a continuos automated check will prevent.

   ## NOTE: Refrenece url for vale stream mangement => dojoconsortium.org


### 5. PLATFORM AS PRODUCT - Lectured by (Bryan Finster and Courtney Narno)
    - Platform Mission & Goals (Duration: 10:23 mins)
    - Platform as a Trusted Product (Duration: 11:16 mins)
    - Productizing the Platform (Duration: 19:42 mins)
    - Scaling our Platform (Duration: 17:05 mins)

 ### part 1: Platform Mission & Goals

 ## What is DevOps?
  The union of people, process and product to enable the continuous delivery of value to the end user.
  This looks similar to the Organization Goal as well.

  ## Platform Mission

  General definition of a platform is anything we do that does heavy lifting of toil that's really common, and try to automate that away. So it could be something like self-service database where i can ust click a button and get a new database or you know, the thing thaat we're going to talk about today is specifically around the delivery platforms.

  - How do we deliver code changes to the end user?
  But i consider a platform to be anything we're doing to try to remove frictions from the process.

  ## Platform Product Goals
  - Reduce devlivery friction
  - Reduce cost of change
  - Make the right things easy
  - Help the other teams excel

  Many Organization are not be focus on a platform team that, we're not there yet, 
  so what we're going to do is we'll ust form the teams, and then it'll be up to them  
  to figure out how to deliver.

  ## Taming the Chaos: Developing a Common Platform

  
  - Common solution that removes duplication
  - Easier to train and use
  - Implements organizational goals

  And the problem with that is it causes all sort of issues. And by focusing on building on a 
  platform team early on, we can have a removal of duplication, and it makes it a lot easier for 
  teams to focus on what they are doing, instead of how to get it done.

  - It eases training. You don't have every team have their own solution that they have to train anybody that comes on the team.

  And also, it's very important, it implements organizational goals. And breifly on that, just a story from my past.

  At prev org, we had the goal of every team implementing continuous delivery. And the platform made that easy.

  It made non-CD flows more difficult or it didn't make it easy, you could still do non-CD flows, bit it was ust painful to do it. But if you wanted to do CD, it was super easy.

  So, is there a rule of thumb from your past on how big does an organization have to be before they implement a platform team, how big should they be?


  Refer the following topic.


  ## Change Org Topology to Improve Flow
  _________________     _________________     _________________    _________________
  |               |     |               |     |               |    |               | 
  |               |     |               |     |               |    |               |
  |  Product Team |     |  Product Team |     |  Product Team |    |  Product Team |
  |               |     |               |     |               |    |               | 
  |______________ |     |______________ |     |______________ |    |______________ |
  |               |     |               |     |               |    |               |
  |   platform    |     |   platform    |     |   platform    |    |   platform    |
  |_______________|     |_______________|     |_______________|    |_______________|          

And you know, if we look at this slide here, right, we can already  see that we have these four teams, and each one of them has a platform with a lot of duplications, right?

And if we reorganize things to here, we get a lot better flow.


___________________________________________________________________________________
  |               |     |               |     |               |    |               | 
  |               |     |               |     |               |    |               |
  |  Product Team |     |  Product Team |     |  Product Team |    |  Product Team |
  |               |     |               |     |               |    |               | 
  |_______________|_____|_______________|_____|____________________________________|
  |                                                                                |
  |                                     platform                                   |    }_________________________________________________________________________________|

  And this actually reflects a reality that i personally experienced where in a very large organization, where we just piloting continuous delivery to see if it was something that would work for us.

  And we had literally four teams out of a big area, where we had a lot more than four teams in that area.

  And we created a platform team to do the heavy lift, so that each one of the teams didn't have figure out how to implement a platform to do CD.

  And that platform team consisted of like three people. It doesn't take much to get started. It just, you know, you need to make sure that you're organizing early on, because doing that early on allowed us to avoid all sorts of problems down the road.

  ## General usecae
  I think that typical organizational pitfall where, if we're building it, and i only have the context, i'm less likely to talk to you, to other people who might be doing similar or adacent work, right, because i've built my own stack from the group up. So just an enormous amount of inefficiency. 
  
  And then on the right hand side, it seems like an organizational byproduct of that, is that you are going to drive better communication amongst team too, if they have this common foundation that they're operating off.

  And that's true, one of the outcomes of that was that we were working very closely, each one of the product teams was working very closely with the platform team to get an feedback on what they were building, and how we could make it better for everybody else that was going to be in the next round after the pilot.

  And we were the teams were working with the each other on good ways to ue platform.

  So, it was you had this feedback loop constantly that was improving hown the platform was being used and the platform itself.

  ## Knowledge Check
  1) Only large organization needs a common platform?
  **False**: Product team should be able to focus on what to deliver, not how to deliver. If every team is solving the delivery problem, the organization is creating technical debt that will slow delivery.

  2) A Common platform can accelerate value delivery?
  **True**: A properly implemented delivery platform will decrease the effort and cost required to deliver stable, secure and usefu change.

  3) The goal of platfrom team is to enforce policy?
  **False**: Platform teams should make the right things easy while helping product teams to remove toil and cost from product delivery.

  There is a compliance component that platfrom team can play, but their job isn't to be cops, their job is to make being compliance easy.

### part 2: Platform as Trusted Product

- Establish a brand identity
- Establish brand goals
- Build a roadmap of problems to solve
- Start small and scale
- Focus on customer experience

## Trusted Product, not a "Tools team"

## Failure Modes
- Painful solutions
- Good solutions with 
        poor documentation
        poor training
        that don't fit their need
        thay are forced to use
  
## Knowledge Check
1) Deploying the best possible delivery tools will solve the problem?
**False**:  Tools without guidance can cause more problems than they solve.

2) Team should not be forced to move to a common platform?
**True**:  Forcing tool change will not result in good outcomes. The common platform should be a better solution so that team want to move.


### part 3: Productizing the Platform

 ## Implememnt Organization Goals
 - Rapid Onboarding
 - Increased reuse
 - Automate process overhead
 - Security & Compliance
 - Continuous delivery 

 ## Focus on Customers Needs
 - Easier to use
 - Good support and training
 - User outreach and meetups
 - Community building

 ## Make the Right Things Easy
 - Templates for preferred patterns
 - Seed applications
 - Common developer experience
 - Useful documentation

 ## Make it extensible
 - We cannot predict every problem to solve
 - Keep customers safe while they solve their own problems
 - Make common solution easy to implememt
 - Partners, not police

 ## Knowledge Check
 1) The platform should make every existing workflow easier?
 **False**: We should make more efficient workflows easier. Less efficient workflows shouldn't be impossible, but the platform should encourage improvement.

 2) Building a user community is important?
 **True**: A robust user community helps with cross-training teams and provides rapid feedback on feature priority for the roadmap.

 3) The platform should define strict patterns for usage?
 **False**: The platform should include organizatable non-negotiable around security and compliance but should enable teams to configure workflows that are contextual to delivery problem.


### part 4: Scaling our Platform



### 6. WHAT IS CONTINUOUS DELIVERY AND WHY IT IS IMPORTANT
    - Why CD? (Duration: 22:45 mins)
    - It is ust Tools? (Duration: 31:53 mins)
    - Common Challanges (Duration: 21:33 mins)
    - Exploring the pipelines (Duration: 19:08 mins)
    - Getting Started (Duration: 13:07 mins)


### Part 2: It is ust Tools?

 ## Change the Mindset
 ## Change the Mindset
 ## Change the Mindset
 1. Deliver First: Establish the ability to verify assumptions quickly and safely
 2. Ability to deliver is our high priority. Keep the pipeline green!
 3. Small, frequent changes not big bang releases.
 4. Automate!
 5. Rapid feedback to prove hypotheses, not assumption of success.
 6. Remove toil and work smaller, not wotk faster
 7. Breakdown communication silos and minimize handoffs
 8. Build quality in. Quality is process, not a job.

 Case Study: We had another team in my prev company who deployed something that blew up production and the business freaked out and locked down all teams from delivering anything until they could overcome their fear.

 My team had a very high success rate on quality. Any defects we had were always small and they shit down our ability to deploy. We had been deployed multiple times a day, and it was large team, much too large actually.

 And we had 14 people pushing changes to the trunk to get to be the deployable every single day.

 And in my head, as the tech lead, I'm just imagining these huge haystack we're building and all the potential needless in that haystack growing daily, right? On day seven, I panicked and escalated and told my SVP that they either open our pipelines or we're going to cause a huge problem, and we just need to stop working. And they did. And there were some defects and we fixed them and then we continued to flow.

 But the mindset shift of ust imagine every haystack has a needle, every single one. And the bigger the haystack is, the more needles it is.

 ## Impact to teams
 - Improved quality
 - Reduced process toil
 - Improved teamwork
 - Improved morale
 - Teams that do not have birth to death ownership will struggle to deliver quality outcomes.

 **Definitions of Productivity**:

 ## Impact to the Organization
 - Improved communication
 - Improved collaboration
 - Improved value delivery
 - Happier teams
 - Happier customers
 - Ability to try new ideas with less cost of risk.

 **"CD is much much more than just build and deploy. It represents an organization's circulatory system."**

 ## Quiz Time
 1. When implementing CD, the first thing to do is to implement pipeline tools?
 **False**: We need to understand the delivery problem we are trying to solve it first and evolve tools to solve it.

 Famous Quote said by David Glass, who sais, **"Eliminate and then automate"**

 2. There is no Quality Assurance steps in CD?

**True**: In CD, quality feedback loops are built into everything we do from refining requiements to getting user feedback.

3. One of the benefits of CD is that teams are more productive?
**False**: Unless you define productivity using value vs output. Team delivers more value sooner, safer and happier.

**"Manufacturing is measured by pieces produced. design work is measured by the value delivered"**



### Part 3: Common Challanges

## Common Challanges (Team)
- "We automated the build. we are doing CD!"
- Testing knowledge
- Work decomposition   => DojoConsortium website has a whole section on work decomposition.
- Teamwork
- Process overhead

## Common Challanges (Org)
- Functional Silos
- Lack of a good platform
- Misaligned goals
- Well defined products
  Case Study: Melvin Conway in the late 60's, said that design of a system is constrianed by the organizational structure that built it, the communicational lines that built it. And if you want an application, you know, if you want your products to be architected in a way that they can be delivered most efficiently, then really what you want to do, is you want to study domain drive design, strategic domain driven design, talk about the business sub-domains of those products, the discreet capabilities that those products implement, and then design teams to own those capabilities. You don't want to be focussing on, "Hey here's a feature for the product."

  And that allows the team to be loosely coupled, hightly cohesive and deliver things independentlly of each other as long as you do other things around, you know, good contracts and things like that. But good product definition and the sub-domains is critical.

  ## Quiz Time
  1) We need to hire better people for CD to work?

  **False**: CD is the tool to enable the smart people you alredy have and the teams they comprise to be more effective.

  **CASE STUDY:**  minimumcd.org that talks about the problems to solve and how it improves your orgganization.

  2) We need to solve all of these challanges to start implementing CD?
  **False**:  CD is the tool to help discover and solve the challanges not the goal.

  3) CD is an effective tool for enterprise transformation?
  **True**: CD helps incover many core organiational issues that are impacting teams and customers. CD is the tool not goal.

### Part 4: Exploring the pipelines

CD as "Automate What We Have" => What that really  equates to is we automate what we have today.

## Quiz Time:
1) CD automates build anf delivery?
**False**: CD is a hollistic system that includes automation to make delivey safe, secire and boring. However we operate is more important.

2) Manual testing never happens in CD?
**False**: There should be no manual testing as a stage gate, but we are always working to find new things to tests and evaluating usability as we evolve the product.

### Part 5: Getting Started


### 7. THE POWER OF CULTURE
- Overview (Duration: 3:03 mins)
- What Does Culture Fit (Duration: 5:25 mins)
- Culture and HR (Duration: 12:49 mins)
- How to Drive Culture (Duration: 8:16 mins)
- GitOps for Culture (Duration: 10:07 mins)
- Insubordination (Duration: 6:29 mins)
- What to Do if Your Organization Is Culturally Broken (Duration: 16:42 mins)
- Review (Duration: 3:41 mins)

### Part 2: What Does Culture Fit

  ## Pyramid of People, Culture, Process, Tech

### Part 3: Culture and HR
 
 ## HR Matters
  -  How you recruit people matters
  - How you hire peoplw matters
  - How you treat people matters
  - How you inspire people matters
  - How you lead people matters
  - How you follow people matters

### Part 4: Power of Culture

  ## How to Drive Culture

   Any time you're going through any type of organizational transformation, and you truely want to drive culture, that culture change is relly, really only possible if leadership is not only on board, but the ones driving it.

   However, a leadership team that's driving culture, isn't actually going to change anything themselves. What they actually need is individuals within the organization driving towards the same exact goals, with the exact same purpose, and feeding off the cultural sort of the cultural sort of push and nudge giving off from leadership, but driving the same direction, from a day to day execution perspective.

   Well I'll say you can't ust throw up posters and drive culture, and you can't ust speak about it and drive culture either. You have to make it people beleive it by examplifying the culture you want to drive.

   And make sure you have the right incentives because if yoy go out there and say, "Go forth and break things", and somebodyy goes forth and breaks something, if you punish them, you haven't actually driven culture, you've actually done the opposite.

   Yoy have driven culture, just not the one you want. It's not exactly what you were going for.

   So, who exactly, Bryan, do you think drives culture?

   You know, I think it really gets established at the top, because, you know, as high up as you can go, this is the intentional outcomes i want from a culture.

   I mean, I worked for a long time at Walmart. Mr Sam was intentional about his culture. And expected that to be driven down from every level.

   And he would go and talk to the people, doing the work, they were seperated a great distance in the report chain from him. And to see the culture was going the way he wanted it.

   But the culture gets executed by the people actually doing the work.


   ## Good Examples of Shared Vision
   So, good examples from a cultural perspective are in many cases, example where organizational have common or shared vision.

   Two of the best organizations that i think  have exemplified this is both NASA and SpaceX.

   ## Is Culture Intentional or An Accident?

   ## Review
   1) Culture is an accident?
   **False**: You have to be intentional. Otherwise culture is ust going to spiral out of control and you're not going to actually maintain it. And withput culture, you can't build effective processes, and withut effecctive processes, you can't effectively build technology.

   2) Culture is driven by the entire organization, from the senior leader/CEO all the way to the newest or most junior hire?

   **True**: You leadership and management position many times set the vision, but within the organization what's actually going to produce the outcome is the day-in-day-out involvement of everybody.

   And that includes not only management but the newest, most junior hire.

   If the newset people come into an organization and don't reflect the same culture, then over time that culture is going to atrophy.

   ### Part 5: GitOps Culture

   GitOps is really looking at declaratively updating an Ops or Production system looking at either your, generally, infrastructure as code and configration as code, which is typically managed within some Git technology, GitLab, GitHub, and continuously pushing out by changing the actual Git repository itself which then gets pulled into the production or operational environment and reflects it as a declarative baseline update in production.

   How does it relate to culture?

   I think easy way to think about GitOps is updating a system to where the system is reflected as everything is code. So the system is reflected as code.

   It's codified and you're continuously updating the system in Ops by simply changing the code which then changes the actual system itself.

   So, once again how the heck does that relate to culture?

   And that is that culture needs to actually be declared as well. You know, culture to be successfull, culture can't be ad hoc.

   Culture, once again, isn't, you know, that we have dogs in the office. How do you know that you have a good culture?

   Oh, cause I can bring my dog into the office. No that's not what good culture is. 

   What good culture is the entire organization aligning itself towards several or many key principles or values that the organization agrees are important.

   Yeah. you know, this is how we go about our mission. This is how we treat each other.

   You know, having explicit policies around how we implement our culture.

   It's so important, you don't want to leave it up to chance because if you have misunderstandings, you don't have a cultural startup point too.

   Yep, it's how to interpret information. It's how to talk to each other. How to talk to external people, how to balance priorities.

   You know, all of these things can get codified as culture.

   And when we say declared, we mean write it down. It sounds crazy, but you should actually dissect what culture you want to have and actually write it down.

   ## How to Measure Culture

   Once you write it down, the next question you need to ask yourself is, how good we are doing based upon what we've written down.

   Which you don't really know, quote, what "good" is without measuring culture.

   I know metrics matter, metrics are a huge deal to you. 
   
   Do you have any ideas on how one might measure culture?

   Culture is a really tricky one to measure, especially in a large organization, because, and let's say that you have an accidental culture and you're trying to be more intentional to get a better culture.

   You first have to establish a level of trust. It's like a catch 22. You have to establish a level of trust before any sort of metrics that you could use to measure how culture is going will valid.

   But how you know that you have level of trust? And so I, you know, there's things, I've seen around, like employees NPS scores, you can get 360 feedback on how people are feeling, but i would say that like many other metrics, i would look at those as things that, if they're reporting things going well, that doesn't mean things are going well.

   But, if they're reporting things going badly, that doesn't mean things are going badly.

   And you know, I will say that ther's no absolute obective way to measure culture, but it's important to have severla measuring sensors and probes out to know, sort of leading indicators when culture is going in a negative direcction; you know, surveys help but surveys need to be timely. They need to be taken with a grain of salt.

   Personal dialogues and discussions between leadership and individuals to get a feed on people is incedibly valuable.

   People's happiness is tremendously important because if your culture is right, then people will in general feel valued, which is going to help their retention.

   But they're also going to feel as if they're making a difference. which them feeling they are making a difference is actually directly correlated to their output.

   which is directly coreleated to you as an organization and your outcomes.

   And there are some hard metrics you can look at that could give you some leading indicators when culture might be at risk.

   You can look at how many hours people are working outside of normal hours.

   You can look at how many total hours people are working per week.

   You can look at the turnover rate in the organization or the teams, and track that over time and see, because turnover normal, but if it becomes excessive, you know, what's going on?

   Not only on your retention rates, but  also captured on the exit interviews, why they choose things.

   And if thay sa, you know, quote, "I had to do what's best for my family" end quote.

   ## How to Change Culture

   ## Review
   1) In the same way that you can build declarative infrastructure, you can design an organization with declarative culture?

   **True**:

   2) The Culture of an organization cannot change over time?

   **False**

   ### Part 6: Insubordination

   Insubordination, which normally is thought of as a very very very negative term, especially you are working in an organization that is very bureaucratic, very rigorous.

   Anybody working for the military or the federal government might look at the word insubordination as something that it only has negative context.

   However respectful insubordination, if used in the right way, is effectively exactly what you want your teams to have in order to drive your organization to the right results.

   Bryan, you have any thoughts or any previosu experience on what insubordination might have actually what an organization needed to find success?

   I would say that most improvements are going to come from insubordination, again that resppectful insubordination, people who understand what their North Star is and are doing the right thing, even though they don't have permission to do right thing.

   I think it'ss important that you're doing the right thing.

   And i'd say that lot my career has been built on just doing the right thing because, and not asking permission, there's some organizations where that's explicitly part of the ways of working is to ust to do the right thing is swim upstream, find new and better ways to get things done.

   ### Part 6: Insubordination

### 8. THE RIGHT METRICS (Lectured by Bryan Finster and Austen Bryan)
- What should we Measure and Why (Duration: 20:16)
- Effectiveness (Duration: 22:34)
- Efficiency (Duration: 33:12)
- Sustanability (Duration: 24:52)

### Part 1: What should we Measure and Why

 ## Course Obectives
  - Why are metrics important?
  - What should we measure?
  - What are common problems faced?
  - How can we avoid the pitfalls

## Metrics Inform Improvement

OODA Loop (Observe->Orient->Decide->Act).

What does that mean?

How to make decisions quickly, especially in high intensity situations and make it very small iterative, repeatable process, which is really, when i think about DevOps, it's really taking the scientific method and saying how short can we make that feedback loop to make decisions based on feedback from the production system?

And so i think the same concepts of just decision making at large apply here to DevOps as well.

Yeah, I do too, i never served in military, but when i started really digging into continuoud delivery and DevOps, and i think we should pause for a moment.

DevOps is one of those words that is just massively overloaded in the industry.

Donovan Brown had a definition that i really like: a lot of people think DevOps and they have DevOps engineer or DevOps teams and DevOps tools and they all think it's automation, a lot of people do. It's unfortunate. But Donovon Brown definition really spoke to me. It was the union of people, process and product to enable the continuous delivery of value to the enduser.

And if you look at that, what we are trying to do? I mean, we're trying to improve the flow of ideas.

If we have an idea, how can we find out number one, if it's a good idea, as fast as possible so we don't spend a lot of money on bad ideas?

And then also get feedback on the execution and knowing where we are at the beggining i think is super important and that we need to observe, and metrics give us our first opportunity to observe.
We need to baseline where we are before we can improve anything right?

I think, data driven decision is another buzzword that at least is in the DoD ecosystem and you can't really make decisions to pivot or persevere if you just think about Agile concepts unless you know where you're standing now and what you're evaluation against.

## Measuring Behaviour Changes Behaviour

The thing that a lot of people i think miss out is that software product development is all about people. And when we start measuring that, and if we're not measuring what's happening in production, thinks like are we stable or not?

We're measuring everything left of production - is how people work.

## Cynefin

- Complex     => Probe, Sense, Respond       => Emergent
- Complicated => Sense, Analyze, Respond     => Good Practice
- Chaotic     => Act, Sense, Respond         => Novel
- Simple      => Sense, categorized, Respond => Best Practice

## THE COBRA EFFECT

**A well intended measure can often backfire and have the opposite effect to intend**

- INTENTION - Reduce Cobra population
- ACTION    - A Bounty for Dead Cobra
- EFFECT    - People start Cobra Farming.

## Velocity in Agile

What's our velocity?

And velocity is like the number of story points that a team completes in an iteration and, "Oh we need our velocity to go up."

Well, velocity is based off of story points and story points are based off of nothing. It's almost like BitCoin.

And so one team's story point...two story point in one team might be five in another team. And because they're not based on anything, if you say, "Well, i want your velocity to increase". And all we have to do is increase our story points because thet're just estimates, we just make our estimate bigger.

And, if we deiver in less time, hey, that's great, we're doing awesome.

It doesn't help us at all but it sure makes people feel good.

## Misusing Metrics

There was a time in government for me where i was trying to learn contractually how to bring on development teams to create a product, right?

And another government organization was sharing their best practice with me and they told me it was small contract options based on amount of story points of capacity you wanted to buy. And i was like, "Well i have been a developer before that's used story points".

I was like, "I can make up whatever story points i want". So depending, I'm sure people aren't mal-intended and being malicious,



### Part 2: Effectiveness

## What Should We Measure

We can break down in to categories:
 - Effectiveness
 - Efficiency
 - Sustainability

 ## New Keywords
 - North Start
 - OKRs

 What an OKRs is?

 - Small Iterative changes
 - Validate outcomes
 - Adust short term OKRs to get closer to long term goals

 OKR is an obective with key results.

## Organization OKR
Deliver irresistible developer experience

- Hold 2 user feedback session per month
- Improve developer rating from 3 to 4 stars
- Increase platform users from 20 to 200
- Publish 3 online training classes

## Team OKR
Make pipeline configuration easy and automated

- Reduce support requests by 50%
- Reduce platform onboarding from 3 days to 10 minutes
- Increase number of onboarded repositories 5 to 20


## Review
1) The best measure of effectiveness is the number of features delivered?
**False**: We should measure outcomes.. Are our users satisfied with the results? Are we solving their problems.

2) OKRs should be focused delivering specific features?
**False**: OKRs whould be aligned to the impact we are trying to make and contain obective measure that we are acheiving that impact.

3) We need a clearly organizational mission to effectively measure progress?
**True**: Without a guiding North Star, the metrics have nothing to inform thier use.

### Part 3: Efficiency

- System thinking
- Amplify the feedback
- Continuous improvement

What is DORA metrics?

## Types of Waste
- Over-Engineering waste
- Inventory waste
- Handoff waste

- Wait time between steps is the biggest killer in efficiency.

- This session more related Value Stream Map which we discussed in earlier sessions.

## Review:
1) A value stream map measures value delivery
**False**: A value stream map is used to identify the main constraint in the delivery flow.

2) Wait time is the leading cause of waste in most value strams?
**True**: Handoffs between steps reduce the efficieny of the delivery flow and degrade feedback.

3) Flow efficieny is productive metric?
**False**: Flow efficiency indicates how much time is spent waiting relative to the total time.

4) Delivery frequency is a leading indicator for productivity?
**False**: Delivery frequency is the lagging indicator for reducing the size of each change.

5) Every metrics need one or more guardrail metrics?
**True**: To prevent perverse incentives, every metrics needs one or more metric that can identify that behaviour change.

### Part 4: Sustanability

## Review:
1) Mesuring team health indicator are as important as measuring efficieny?
**True**: Team health is leading indicator for quality, stability and security. Burnout decreases quality and increase turnover.

2) Technical debt is a technical problem?
**False**: Technical debt is business problem. As the complexity of every change increases, throughput and quality decreases.

## Closing Thoughts
- Metrics are a critical part of the improvement toolbox 
- We cannot measure our way to improvement
- Don't measure people, invest in them. They are our most valuable asset.



### 9. AGILE CONTRACTING
- Agile Contracting (Duration: 10:51 mins)
- Agile Contracting for the Government (Duration: 13:59 mins)

### 10. CYBERSECURITY

### 11. COURSE COMPLETION



https://software.af.mil/dsop/documents/
https://minimumcd.org/
https://dojoconsortium.org/docs/vsm/