trigger rajan1_tri on Account (After Insert) {

Account [] accs=Trigger.new;
test_rajan.fun(accs);

}