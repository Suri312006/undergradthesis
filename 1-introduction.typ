#import "@preview/illc-mol-thesis:0.2.0": *

#show link: it => underline(text(fill:blue)[#it])

#mol-chapter("Introduction")

Twizzler is a research operating system focused on new programming paradigms
possible via NVM (Non-Volatile Memory)@twizzler. It gives programmers direct
access to underlying data by removing the kernel from the datapath, which
results in huge performance gains, while using NVM to make that data persistent
across power cycles. However this reimagining of an operating system leaves many
questions for how security is undertaken.

// talk about the standard unix abstractions

In mainstream operating systems, an omnicient and all-powerful kernel enforces
security policy at runtime.  It acts as the bodyguard, holding all I/O and data
hostage unless the requesting party has the authorization to access some
resource. This tight coupling of security policy and access mechanisms works
well since any access must be done through the kernel, so why not perform
security checks alongside accesses? This coupling gets challenged as soon as one
tries to decouple access mechanisms from the kernel, as we see in Twizzler.

== Data-Centric Operating Systems

Twizzler defines itself as a data-centric operating system, meaning
it is built upon two key principles @twizzler:

  + Providing direct, kernel-free, access to data.

  + Pointers are tied to the data they represent.

// I would add a paragraph motivating the data-centric approach
// like why would i want the kernel out of the way?
These principiles emerge from treating persistent data as a first class citizen.
Since NVM removes the necessity of the kernel to serialize and deserialize
data from storage devices and memory, it only makes sense for it to be removed
from the access path.  If applications want to utilize memory as truly
persisent, they require a persistent way to access that memory, leading to a
notion of persistent pointers. 

// this talks about why this kind of access rights is a secuirty issue.
With the decoupling of the kernel and access methods, we have to rethink
how security policy for objects is enforced. While the kernel doesn't manage
the connection between applications and data, its still responsible for
creating that connection. This provides one area of enforcement, where
the kernel can check access rights before granting the application access
to the object, and then stay out of the way after. Twizzler programs
the MMU, per thread, to grant access rights, allowing for a point of enforcement; more
detail can be found in section 4.2. Now we have to build the underlying system that
must be enforced.


== Capability Based Security Systems
Capability-based security systems have a rich history in research, and offer an
alternative approach to security, in opposition to the Access Control Lists of
prevalent OS's @linux_security.  Boiled down, a capability is a token of
authority, holding at minimum some permissions and a unique identifier to which
"thing" those permissions apply to @cap-book. There are some
additions we make to this basic defenition in order to apply capabilities in Twizzler,
most notablity the addition of a cryptograhic signature. Since capabilities
are stored on-disk, the kernel needs a way to ensure the policy its enforcing
is coming from a trusted entity. If this weren't the case, it would be trivial
for a bad actor to manipulate capabilties, and the kernel would be
none-the-wiser as it goes to enforce it.  Thus we have this construciton of an
cryptographically signed capability, in which the kernel only enforces after it
verifies the signature to be authentic.

This paradigm permits kernel-free access of data, while also guaranteeing
security by enforcing it right before the point of access through the MMU. 

== Our Contributions
In this thesis, I detail the fundamentals of security in the Twizzler
operating system, and discuss how I implement and refine some of the high
level ideas described in Twizzler @twizzler and an early draft of a Twizzler security
paper @twizsec. Additionally, we evaluate these systems inside kernel and user space, using
Alice/Bob scenarios and microbenchmarks. 

A list of merged PR's to Twizzler:
+ #link("https://github.com/twizzler-operating-system/twizzler/pull/267")[Old Security Port to Main]
  - Implementation of SigningKey and VerifyingKey mentioned in seciton 2.
  - Implementation of Capabilities mentioned in section 3.
  - Support to compile twizzler-security for the kernel and userspace

+ #link("https://github.com/twizzler-operating-system/twizzler/pull/273")[Adds creation of SigningKey / Verifying object pairs.]
  - Implementation of the keypair objects containing singing and verifying keys, mentioned in section 2.
  - Userspace tests for keypair creation and usage of signing / verifying keys.

+ #link("https://github.com/twizzler-operating-system/twizzler/pull/275")[Security Contexts and Benchmarking]
  - Implements Security Contexts for kernel and userspace, as described in section 4.
  - A benchmarking framework for the kernel.
  - Benchmarks for cryptographic operations inside the kernel, and can be viewed in seciton 5.
  - Userspace benchmarks of security policy creation, as shown in section 5.

More details can be found in this
#link("https://github.com/twizzler-operating-system/twizzler/issues/268")[Github
tracking issue].

#load-bib(read("refs.bib"))
