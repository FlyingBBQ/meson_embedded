# include the test framework
cpputest_dep = dependency('cpputest', version : '>=3.7', native : true)

# add your test sources
test_src = files('sometest.cpp')

test_exe = executable(
  'test_exe',
  [test_src, 'cpputest_main.cpp'],
  link_args : ['-lpthread', '-lCppUTest', '-lCppUTestExt'],
  override_options : ['b_asneeded=false', 'b_lundef=false'],
  dependencies : cpputest_dep,
  native : true)

# make the test executable visible to the build system test framework
test('Unit tests', test_exe)
