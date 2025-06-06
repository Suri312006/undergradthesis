#import "template.typ": *

#mol-chapter("Security Contexts")

Security Contexts are objects that threads attach to in-order to inherit access
rights, represented as capabilities, inside the context. Additionally, a thread
can attach to multiple security contexts, but can only utilize the permissions
granted by one unless they switch @twizzler. The contexts store capabilities,
allowing for userspace programs to add capabilities to contexts, and kernel
space to efficiently search through them to determine whether a process has the
permissions to perform a memory access.

== Base

Since security contexts can be interacted with by the kernel and userspace, there needs to
be a consistent definition that both parties can adhere to, which we define. Objects in Twizzler
have a notion of a `Base` which defines an arbitrary block of data at the "bottom" of an object
that is represented as a type in rust. We define the `Base` for a security context as follows:

```rust
struct SecCtxBase {
    map: Map<ObjID, Vec<CtxMapItem>>, /// A Map from ObjIDs to possible capabilities.
    masks: Map<ObjID, Mask>,          /// A map from ObjID's to masks.
    global_mask: Protections,         /// Global mask that applies to granted prots.
    flags: SecCtxFlags,               /// Flags specific to this security context.
}
```

=== Map
The map contains positions of capabilities related to a target object, enabling
kernel and userspace to look for capabilities inside security contexts.
Implicitly, the kernel uses this map for lookup while the user interacts with
this map to indicate the insertion, removal, or modification of a capability.
The `Map` type here and for `masks` is a flat data-structure, and stores offsets
into the object where capabilities can be found for a target object.


=== Masks
Masks act as a restraint on the permissions a context can provide for some target object.
This allows for more expressive security policy, such as being able to quickly restrict
permissions for an object, without having to remove a capability and recreating one with the
dersired restricted permissions. 

The global mask is quite similar to the masks mentioned above, except that it operates on
permissions granted by the security context as a whole rather than a mask per distinct object id.
// what now
//
=== Flags
Flags is a bitmap allowing for a Security Context to have different properties. Currently, there
is only one value, UNDETACHABLE, marking the security context as a jail of sorts, as
once a process attaches to it, it won't be able to detach. This acts as a way to
limit the transfer of information if a thread attaches to a sensitive object. Once a thread
attaches to such a context, it is forced to end its execution with the objects that context grants
permission to. We also plan to utilize these flags in future works, as described in 6.1.


== Enforcement

All enforcement happens inside the kernel, which has a seperate view into Security Contexts
than userspace. The kernel keeps track of all security contexts that threads in Twizzler
attach to, instantiating a cache in each one.  To manage these threads, the kernel assigns a Security Context Manager,
which holds onto security context references that a thread has.

There exists only 1 point of enforcement for security policy if we wish
to keep the kernel out of the access path; the creation of the path itself!
On page fault, the point in which a process requests the kernel to map in an object, is
when we have access to the security policy we seek to enforce (the signed capabilities inside the security context), the
target object, and most importantly, kernel execution! Its the only time
we can program the MMU according to the desired protections, and transfer control
of enforcement to the hardware @twizzler.

Upon page fault, the kernel inspects the target object and identifies the
default permissions of that object. Then the kernel checks if the currently active
security context for the accessing thread has either cached or capabilities that provide
permissions. If default permissions plus the active context permissions arent enough to
permit the access and the security context isn't a jail, the kernel then checks each of the inactive contexts to see if they
have any relevant permissions. If there exists such permissions, then the kernel will
switch the active context of that process to the previously inactive context where the permission
was found. If it fails all of these, then the kernel terminates the process, citing inadequate
permissions. 






// why should enforcement work this way?

// may be worth summarizing a few more bits here
// doesnt have to be super detailed or anything but its better to havea ... thing tie together
// than and a parathere with "etc"
//
// eg. recovering posix semantics and why thats desirable, allowing for
// "contained" threads, ...
//
// basically talk more about stuff from the original twizzler paper about why this style of enforcement
// is good, its fine to benefit

#load-bib(read("refs.bib"))
