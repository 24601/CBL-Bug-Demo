Demonstrates https://github.com/couchbase/couchbase-lite-ios/issues/648 

Launch app in simulator or on device, add a new object, then try to open the object by touching it, will crash with:


20:06:39.575| WARNING: Dynamic property BMArbitraryObject.anArbitraryString has type '@' unsupported by BMArbitraryObject
2015-04-22 20:06:39.576 CBL Bug Demo[17575:1449718] -[BMArbitraryObject anArbitraryString]: unrecognized selector sent to instance 0x7f98cae5ff20
2015-04-22 20:06:39.585 CBL Bug Demo[17575:1449718] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[BMArbitraryObject anArbitraryString]: unrecognized selector sent to instance 0x7f98cae5ff20'
*** First throw call stack:
(
	0   CoreFoundation                      0x0000000101627c65 __exceptionPreprocess + 165
	1   libobjc.A.dylib                     0x0000000103195bb7 objc_exception_throw + 45
	2   CoreFoundation                      0x000000010162f0ad -[NSObject(NSObject) doesNotRecognizeSelector:] + 205
	3   CoreFoundation                      0x000000010158513c ___forwarding___ + 988
	4   CoreFoundation                      0x0000000101584cd8 _CF_forwarding_prep_0 + 120
	5   CBL Bug Demo                        0x0000000100c6a56a _TFC12CBL_Bug_Demo20MasterViewController9tableViewfS0_FTCSo11UITableView23didSelectRowAtIndexPathCSo11NSIndexPath_T_ + 1114
	6   CBL Bug Demo                        0x0000000100c6a82f _TToFC12CBL_Bug_Demo20MasterViewController9tableViewfS0_FTCSo11UITableView23didSelectRowAtIndexPathCSo11NSIndexPath_T_ + 79
	7   UIKit                               0x0000000101fb9dc9 -[UITableView _selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:] + 1293
	8   UIKit                               0x0000000101fb9f0a -[UITableView _userSelectRowAtPendingSelectionIndexPath:] + 219
	9   UIKit                               0x0000000101eec62c _applyBlockToCFArrayCopiedToStack + 314
	10  UIKit                               0x0000000101eec4a6 _afterCACommitHandler + 533
	11  CoreFoundation                      0x000000010155aca7 __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__ + 23
	12  CoreFoundation                      0x000000010155ac00 __CFRunLoopDoObservers + 368
	13  CoreFoundation                      0x0000000101550a33 __CFRunLoopRun + 1123
	14  CoreFoundation                      0x0000000101550366 CFRunLoopRunSpecific + 470
	15  GraphicsServices                    0x000000010500fa3e GSEventRunModal + 161
	16  UIKit                               0x0000000101ec8900 UIApplicationMain + 1282
	17  CBL Bug Demo                        0x0000000100c74007 main + 135
	18  libdyld.dylib                       0x000000010393e145 start + 1
	19  ???                                 0x0000000000000001 0x0 + 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException
(lldb) bt
* thread #1: tid = 0x161ef6, 0x0000000103c5d286 libsystem_kernel.dylib`__pthread_kill + 10, queue = 'com.apple.main-thread', stop reason = signal SIGABRT
    frame #0: 0x0000000103c5d286 libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x0000000103c9042f libsystem_pthread.dylib`pthread_kill + 90
    frame #2: 0x00000001039ec19a libsystem_sim_c.dylib`abort + 129
    frame #3: 0x0000000103ca1481 libc++abi.dylib`abort_message + 257
    frame #4: 0x0000000103cc93d5 libc++abi.dylib`default_terminate_handler() + 267
    frame #5: 0x0000000103195e19 libobjc.A.dylib`_objc_terminate() + 103
    frame #6: 0x0000000103cc6b01 libc++abi.dylib`std::__terminate(void (*)()) + 8
    frame #7: 0x0000000103cc67aa libc++abi.dylib`__cxa_rethrow + 99
    frame #8: 0x0000000103195d2c libobjc.A.dylib`objc_exception_rethrow + 40
    frame #9: 0x000000010155041e CoreFoundation`CFRunLoopRunSpecific + 654
    frame #10: 0x000000010500fa3e GraphicsServices`GSEventRunModal + 161
    frame #11: 0x0000000101ec8900 UIKit`UIApplicationMain + 1282
  * frame #12: 0x0000000100c74007 CBL Bug Demo`main + 135 at AppDelegate.swift:12
    frame #13: 0x000000010393e145 libdyld.dylib`start + 1
