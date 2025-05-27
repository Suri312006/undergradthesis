#import "@preview/illc-mol-thesis:0.2.0": *

#mol-chapter("Introduction")

// talk about the standard unix abstractions

In mainstream operating systems, security policy is enforced at runtime by a
omnicient and all powerful kernel.
// what am i trying to say here.
It acts as the bodyguard, holding all i/o and data protected unless the
requesting party has the authorization to access some resource. This tight
coupling of security policy and access mechanisms works great since the kernel
is always *there* and the only way to access anything through it. However
the enforcement of security policy starts getting complicated when we try
to seperate the access mechanisms from the kernel.


== Data Centric Operating Systems

Data centric operating systems are defined by two principles @twizzler:

  + Provide direct, kernel-free, access to data.

  + A notion of pointers that are tied to the data they represent.

Mainstream operating systems fail to classify as data-centric operating
systems, as they rely on the kernel for all data access, and use virtualized
pointers per process to represent underlying data. The benefit of this "class"
of operating systems comes from the low overhead for data manipulation, due to the lack
of kernel involvement. However our previous security model fails to operate
here as, by defenition, the kernel cannot be infront of accesses to data. 



== Capability Based Security Systems


// describe capability based security systems
//
// how they are different from earlier thingies

Capability based security systems utilize capabilities, a finegrained 




== Our Contributions

In this thesis, I detail the fundamentals of security in the Twizzler
operating system, and discuss how I implement and refine some of the high
level ideas described in @twizzler and an early draft of a Twizzler security
paper. Additionally we evaluate these systems inside kernel and user space,
with comparsions to micro-benchmarks done with an older version of twizzler.

// describe the twizzler opensource project
//
// my contribution of the existing plan for a security system
//
// its implementation
//
// and benchmarks

#load-bib(read("refs.bib"))
