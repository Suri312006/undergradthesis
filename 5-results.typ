#import "template.typ": *

#show link: it => underline(text(fill:blue)[#it])

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

We have microbenchmarks of core security operations in Twizzler. All
benchmarks were run with a Ryzen 5 2600 with 16 gigs of ram, running Ubuntu
22.04, with Twizzler virtualized in QEMU. The storage backend for all created
objects was volatile.  Unfortunately I ran out of time to perform benchmarks on
bare metal, but hope to find
any discrepencies between virtualized and actual performance in future work. 

== Kernel

The kernel benchmarking framework takes a closure ( a block of code we want to
benchmark ), runs it atleast 100 times, and scales the number of iterations to
reach 2 seconds of total runtime, storing the time it takes for each run. Then
it computes the average, and the standard deviation from the timings.

There are a couple of things we benchmark inside the kernel, including core
cryptographic operations like signature generation and verification, as well as
the time it takes to verify a capability.

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
to measure the difference between a cached and uncached permissions calculation, as well
as how many practical accesses are granted using the cache compared to capability verifications. 
=== UserSpace
Userspace benchmarks were run using rust's built in
#link("https://doc.rust-lang.org/cargo/commands/cargo-bench.html")[benchmarking tool].

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
unpredictable time it takes for the kernel to create an object. The reason keypairs
are almost 2x more expensive because two separate objects are created, one for the signing key,
and one for the verifying key. Performance gains would only be possible from optimizing
how the kernel creates obejcts.
