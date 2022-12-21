# Vehicular Cloud Simulation

## Table of Contents
- [About](#about)
  - [Assumptions](#assumptions)
  - [VM Migration Strategy](#vm-migration-strategy)
- [Building and Running](#building-and-running)

-----
## About
The goal of this project is to simulate a Vehicular Cloud built
on top of vehicles on a highway. The challenge facing the
implementation of the Vehicular Cloud is to minimize job
completion time in the face of dynamically changing resources.

This project simulates a Vehicular Cloud (VC, for short] by
harvesting the compute power of vehicles moving on a highway.

### Assumptions
With such a broad topic, we have to make a few assumptions. First,
we will assume that vehicles can only communicate with the VC if
it is in range of an Access Point (AP). We assume that there is 
an AP at each mile marker, where each entrance and exit is, and 
it has a coverage area of .45 miles in either direction of it. 
That is, if a vehicle is at mile marker 15.5, for example, it 
will be out of range of an AP and its transmission will be held 
until it can reconnect with the next AP.

Since MapReduce is being employed here, we also assume that the
Virtual Machines (VMs), which encapsulate jobs, are smaller than 
your typical VM you would run on a hypervisor, which would be
equipped with a fully-fledged OS. Here, we assume that the VM only
contains the data necessary to execute the job. 

Another assumption made is that, since every vehicle is 
different, so are its specs in terms of CPU cores and memory 
(RAM). With this in mind, if the vehicle has more resources than 
the VM requires, it can use those extra resources in order to 
speed up the work done on the VM.

### VM Migration Strategy
The strategy I ended up settling on was to be picky about which cars 
can receive VMs in the first place. This was done by, estimating the 
transfer time of the VM both ways by assuming suboptimal network 
transfer speed performance, i.e., not the maximum 27 Mbps, as well as 
adding in job completion time to the time calculation. This forces cars 
to be on the highway for an extended period of time to even be 
considered for a VM. This greatly reduces the number of times a VM has 
to be migrated because of the large buffer built into the estimation of 
the transfer, as well as adding time to complete a certain percentage 
of the job. Doing this greatly reduces the number of total migrations 
and significantly reduces the number of failed migrations to close to, 
if not, zero in some cases. Because time to execute a certain 
percentage of the job was factored into whether the VM gets migrated or 
not, this completely eliminates the occurrence of a VM being migrated 
to a vehicle, only for it to then have to be immediately migrated back, 
because the vehicle is about to leave the highway. Overall, using this 
strategy enabled jobs and the associated overhead of being transferred 
to be completed in roughly the same, or in some cases less, time than 
the estimated task length.

-------
## Building and Running
The included Makefile will handle the compiling and building of 
the simulation <code>.jar</code> file. Simply, run the following
command to build the <code>Vehicular_Cloud_Sim.jar</code> file:
```bash
make
```

To run the simulation, just run the following command:
```bash
java -jar Vehicle_Cloud_Sim.jar
```

Once the simulation completes, it will output a summary of the run
to the terminal and generate a log file with the run 
id in a <code>log/</code> directory.