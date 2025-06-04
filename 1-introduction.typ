#import "@preview/illc-mol-thesis:0.2.0": *

#show link: it => underline(text(fill:blue)[#it])

#mol-chapter("Introduction")

// talk about the standard unix abstractions

In mainstream operating systems, an
omnicient and all-powerful kernel enforces security policy at runtime.
// what am i trying to say here.
It acts as the bodyguard, holding all I/O and data hostage unless the
requesting party has the authorization to access some resource. This tight
coupling of security policy and access mechanisms works well since any access
must be done through the kernel, so why not perform security checks 
alongside accesses? However,
the enforcement of security policy starts getting complicated when we try
to separate the access mechanisms from the kernel.

//TODO: explain why this happens?
This problem arises in a certain class of operating systems.

== Data-Centric Operating Systems

//TODO: daniel feedback
// I would add a paragraph motivating the data-centric approach
// like why would i want the kernel out of the way?

Data-centric operating systems are defined by two principles @twizzler:

  + They provide direct, kernel-free, access to data.

  + They have a notion of pointers that are tied to the data they represent.

// then this paragrapch can focus on why removing the kernel
// from the access path is a security probjem
// maybe worth discussing how the access is tied to the mmu as well.
// 
Mainstream operating systems fail to classify as data-centric operating
systems, as they rely on the kernel for all data access, and use virtualized
pointers per process to represent underlying data. The benefit of this "class"
of operating systems comes from the low overhead for data manipulation, due to the lack
of kernel involvement. However, the mainstream security model fails to operate
here as, by definition, the kernel cannot be in front of access to data. So,
something new must be investigated. 

== Capability Based Security Systems



Capability-based security systems have a rich history in research, and offer
an alternative approach to security, in opposition to the Access Control Lists of prevalent OS's @linux_security.
Boiled down, a capability is a token of authority, holding at minimum some
permissions and a unique identifier to which "thing" those permissions apply
to @cap-book. This simple approach of having a "token", allows for a separation
of the kernel's involvement in the creation and management of security policy.
In a well-designed system, as we see in @twizsec and described later, this allows
users to completely create and manage security policy while the kernel is left to enforce
it.

//TODO: how? (via mmu + pagetable mappings programmed via the kernel) (which is still kernel-free for most data accesses)
This paradigm permits kernel-free access of data, while also guaranteeing
security. 

//TODO: maybe add a bit about "unforgeable" tokens, cryptographic operations, why they are needed





== Our Contributions

In this thesis, I detail the fundamentals of security in the Twizzler
operating system, and discuss how I implement and refine some of the high
level ideas described in Twizzler @twizzler and an early draft of a Twizzler security
paper @twizsec. Additionally, we evaluate these systems inside kernel and user space, using
Alice/Bob scenarios and microbenchmarks. 
Code can be found in this
#link("https://github.com/twizzler-operating-system/twizzler/issues/268")[Github
tracking issue].

//TODO: list pr's with a short summary of what each one accomplishes?

#load-bib(read("refs.bib"))
