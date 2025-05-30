#import "template.typ": *

#mol-chapter("Capabilities")


// define a capability
Capabilities are the atomic unit of security in Twizzler, acting as tokens of
protections granted to a process, allowing it to access some object in the ways
it describes. A Capability is built up of the following fields.


```rust
struct Cap {
    target: ObjID,      // Object ID this capability grants access to.
    accessor: ObjID,    // Security context ID in which this capability resides.
    prots: Protections, // Specific access rights this capability grants.
    flags: CapFlags,    // Cryptographic configuration for capability validation.
    gates: Gates,       // Additional constraints on when this capability can be used.
    revocation: Revoc,  // Specifies when this capability is invalid, i.e. expiration.
    sig: Signature,     // The signature inside the capability.
}
```

//
== Signature
The signature inside is what determines the validity of this capability. The
only possible signer of some capability is who ever has permissions to the
signing key object, or the kernel. In this way, if the signer decides to
make the signing key private to them, no other entity can administer this
signature for this capability.  The signature is built up of a array with
a maximum length and a enum representing what type of cryptographic scheme
was used to create it; quite similar to the keys mentioned previously.
The message being signed to form the signature is the bytes of each of the
fields inside the capability being hashed.  There is support for multiple
hashing algorithms as described in 3.1.


// what do i want to talk about regarding signatures?

== Gates

== Flags
Currently flags in capabilities are used to specify which hashing algorithm to use in order
to form a message to be signed. We allow for multiple algorithms to be used in order to
allow for backwards capability when newer, more efficient hashing algorithms are created.

There is also plenty of space left in the bitmap, allowing for future work to develop more
expressive ways of using capabilities, such as planned future work to implement information
flow control into the twizzler security system.



#load-bib(read("refs.bib"))
