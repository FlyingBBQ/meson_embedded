# include the test framework
subdir('CppUTest')

# add your test sources
test_src = files('sometest.cpp')

test_exe = executable(
  'test_exe',
  [test_src, 'cpputest_main.cpp'],
  link_with : cpputest_lib,
  link_args : '-lpthread',
  override_options : ['b_asneeded=false', 'b_lundef=false'],
  dependencies : cpputest_dep,
  include_directories : cpputest_inc,
  native : true)

# make the test executable visible to the build system test framework
test('Unit tests', test_exe)
