trigger rajan_tri on Account (Before Insert) {

Account [] accs=Trigger.new;
test_rajan.fun(accs);

}