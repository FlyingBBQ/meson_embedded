# compile the test executable
# native: use the native compiler instead of cross-compiler
test_exe = executable(
  'test_exe',
  [test_src, 'doctest.cpp'],
  dependencies : doctest_dep,
  include_directories : test_inc,
  native : true)

# make the test executable visible to the build system test framework
test('Unit tests', test_exe)
