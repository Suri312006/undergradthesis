#import "template.typ": *

#import "@preview/unify:0.7.1"
#mol-chapter("Results")

// benchmarking
// micro benchmarks that indicate the relative expense of checks that the kernel would need to do.
// sig time
// verification time
// enc time
// dec time
// via api
//
// make it relative to object size?
//
// take measurements without security checks too so you can see the security overhead
//

== Validation

The first test is a basic scenario as a check to make sure the system is behaving as intended, and
a more expressive test to demonstrate the flexibility of the model. Eventually, I intend to work with
my advisor and peers to form a proof of correctness for the security model, as well
as empirical testing to demonstrate its rigidity.

=== Basic
TBA
== Expressive
TBA


== Micro Benchmarks
Additionally, we have microbenchmarks of core security operations in Twizzler. All
benchmarks were run with a Ryzen 5 2600, with Twizzler virtualized in QEMU. Unfortunately
//TODO:  do not say they they should be the same :sob:, instead say that finding
// the difference between virtualized performance and actual performance is future work
I ran out of time to perform benchmarks on bare metal, but they should be the same, if
not more, performant.

=== Kernel
There a couple of things we benchmark inside the kernel, including core cryptographic
operations like signature generation and verification, as well as the total time it takes
to verify a capability.

//TODO: is this with SIMD in kernel? maybe worth discussing this nuance
//
// how many times did you run the experimnt and how were the stats calculated.
//
// could be interesting to compare signature verification cost as the amount of data
// to verify goes up
// my_note: (wouldnt this only be applicable towards delegations though since others are always
// done properly)
// 
#figure(
table(
  columns: (auto, auto),
  inset: 10pt,
  align: center,
  table.header(
    [Benchmark], [Time]
  ),
  [
    Hashing (Sha256)
  ],
  [
    267.86 ns $plus.minus 163$ ns 
  ],
  [
    Hashing (Blake3)
  ],
  [
    125.99 ns $plus.minus 117$ ns 
  ],
  [
    Signature Generation (ECDSA)
  ],
  [
  199.90 $\u{00B5}s plus.minus 9.45 \u{00B5}s$
  ],

  [
    Signature Verification (ECDSA)
    ],
  [
  342.20 $\u{00B5}s plus.minus 6.28 \u{00B5}s$
  ]  ,
  [
    Capability Verification (ECDSA, Blake3)
    ],
  [
  343.59 $\u{00B5}s plus.minus 5.32 \u{00B5}s$
  ]  
),
caption: [Collection of Kernel Benchmarking Results]
)

We see that signatures are vastly more expensive than hashing, on an order
of $10^3$, meaning that your choice of hashing algorithm doesn't affect the
total time taken for the verification of a capability. It's also important to
note that this cost of verifying a capability for access is done on the first-page fault, then the kernel uses caching to store the granted permissions and
provides those on subsequent page faults into that object. In the future, I hope
to measure the difference between a cached and uncached verification. Secondly,
we only measure verification inside kernel space; as discussed in section 3,
capability creation only takes place in user space.

=== UserSpace

In userspace, we benchmark keypair and capability creation, as these operations are core to
creating a security policy.  


#figure(
table(
  columns: (auto, auto),
  inset: 10pt,
  align: center,
  table.header(
    [Benchmark], [Time]
  ),
  [
  Capability Creation
  ],
  [
  347.97 $\u{00B5}s plus.minus 5.78 \u{00B5}s$
  ],
  [
  Keypair Objects Creation
  ],
  [
  651.69$\u{00B5}s plus.minus 187.90 \u{00B5}s$
  ],
  [
  Security Context Creation
  ],
  [
  282.10$\u{00B5}s plus.minus 119.90 \u{00B5}s$
  ],
),
caption: [Collection of UserSpace Benchmarking Results]
)

Almost all the time spent in creating a capability is the cryptographic operations used
to form its signature, which is why it's in the same ballpark as the signature creation we saw earlier.

The high standard deviation in Keypair objects and Security context creation happens from the
unpredictable time it takes for the kernel to create an object on disk. The reason keypairs
are almost 2x more expensive since they create two separate objects, one for the signing key,
and one for the verifying key.
