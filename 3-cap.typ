#import "template.typ": *

#mol-chapter("Capabilities")


// define a capability
Capabilities are the atomic unit of security in Twizzler, acting as tokens of
//NOTE: point forward towards security contexts?
protections granted to a process, allowing it to access some object in the ways
it describes. Colloquially a capability is defined as permissions and
a unique object to which those permissions apply, but in Twizzler we add
the signature component to allow the kernel to validate that the security policy was created by an authorized party.

Thus, a Capability is represented as follows:


```rust
struct Cap {
    target: ObjID,      // Object ID this capability grants access to.
    accessor: ObjID,    // Security context ID in which this capability resides.
    prots: Protections, // Specific access rights this capability grants.
    flags: CapFlags,    // Cryptographic configuration for capability validation.
    gates: Gates,       // Additional constraints on when this capability can be used.
    revocation: Revoc,  // Specifies when this capability is invalid, i.e. expiration.
    sig: Signature,     // The signature.
}
```

//
== Signature
The signature is what determines the validity of the capability. The
only possible signer of some capability is who ever has permissions to read the
signing key object, or the kernel itself. The signature is built up of a array with
a maximum length and a enum representing what type of cryptographic scheme
was used to create it; quite similar to the keys mentioned previously.
The fields of the capability are serialized and hashed to form the message that gets signed,
and then stored in the signature field. Currently we support Blake3 and
Sha256 as hashing algorithms.

// what do i want to talk about regarding signatures?

== Gates
Gates act as a limited entry point into objects. If a capability has a non-trivial gate,
which is made up of an offset field, and a length field, the kernel will read that and ensure
that any memory accesses into that object are within the gate bounds. The original Twizzler 
paper @twizzler describes gates as a way to perform IPC, and calls between distinct programs,
but in the context of this thesis it is sufficient to think of them as a region of allowed
memory access.

// interesting! I think this model you describe is more general, if we were to add a SWITCH_CTX permission bit... 
// something to think about

== Flags
Currently, flags in capabilities are used to specify which hashing algorithm to use to form a message to be signed. We allow for multiple algorithms to be used to
allow for backward capability when newer, more efficient hashing algorithms are created.

The flags inside a capability is a bitmask providing information about distinct feautures
of that capability. Currently we only use them to mark what hashing algorithm was used to
form the message for the signature, but there's plenty of bits left to use.
We hope for future work to develop more expressive ways of using capabilities, i.e. Decentralized Information Flow Control, as specified in
6.1.

// maybe worth discussing delegations if only to describe how they could be
// extended from capabilities (as a future work ofc)
//
// lowkey tuah lazy to do dis rn, so maybe later, plus i havent talked about
// them at all so im sure daniel is just recomending this as a way to add
// content here, so ill see.


#load-bib(read("refs.bib"))




