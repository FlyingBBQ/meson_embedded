cpputest_inc = include_directories('CppUTest/include', is_system : true)
#cpputestext_inc = include_directories('CppUTest/include/CppUTestExt', is_system : true)

cpputest_src = files(
  'CppUTest/src/CppUTest/CommandLineArguments.cpp',
  'CppUTest/src/CppUTest/MemoryLeakWarningPlugin.cpp',
  'CppUTest/src/CppUTest/TestHarness_c.cpp',
  'CppUTest/src/CppUTest/TestRegistry.cpp',
  'CppUTest/src/CppUTest/CommandLineTestRunner.cpp',
  'CppUTest/src/CppUTest/SimpleString.cpp',
  'CppUTest/src/CppUTest/TestMemoryAllocator.cpp',
  'CppUTest/src/CppUTest/TestResult.cpp',
  'CppUTest/src/CppUTest/JUnitTestOutput.cpp',
  'CppUTest/src/CppUTest/TeamCityTestOutput.cpp',
  'CppUTest/src/CppUTest/TestFailure.cpp',
  'CppUTest/src/CppUTest/TestOutput.cpp',
  'CppUTest/src/CppUTest/MemoryLeakDetector.cpp',
  'CppUTest/src/CppUTest/TestFilter.cpp',
  'CppUTest/src/CppUTest/TestPlugin.cpp',
  'CppUTest/src/CppUTest/TestTestingFixture.cpp',
  'CppUTest/src/CppUTest/SimpleMutex.cpp',
  'CppUTest/src/CppUTest/Utest.cpp'
)

cpputestext_src = files(
  'CppUTest/src/CppUTestExt/CodeMemoryReportFormatter.cpp',
  'CppUTest/src/CppUTestExt/IEEE754ExceptionsPlugin.cpp',
  'CppUTest/src/CppUTestExt/MemoryReporterPlugin.cpp',
  'CppUTest/src/CppUTestExt/MockFailure.cpp',
  'CppUTest/src/CppUTestExt/MockSupportPlugin.cpp',
  'CppUTest/src/CppUTestExt/MockActualCall.cpp',
  'CppUTest/src/CppUTestExt/MockSupport_c.cpp',
  'CppUTest/src/CppUTestExt/MemoryReportAllocator.cpp',
  'CppUTest/src/CppUTestExt/MockExpectedCall.cpp',
  'CppUTest/src/CppUTestExt/MockNamedValue.cpp',
  'CppUTest/src/CppUTestExt/OrderedTest.cpp',
  'CppUTest/src/CppUTestExt/MemoryReportFormatter.cpp',
  'CppUTest/src/CppUTestExt/MockExpectedCallsList.cpp',
  'CppUTest/src/CppUTestExt/MockSupport.cpp'
)

cpputest_dep = declare_dependency(
  include_directories : cpputest_inc,
  sources : cpputest_src)

cpputestext_dep = declare_dependency(
  include_directories : cpputest_inc,
  sources : cpputestext_src)

cpputest_lib = static_library('cpputest_lib',
  dependencies : cpputest_dep,
  native : true)

test_lib = static_library('test_lib',
  include_directories : cpputest_inc,
  sources : cpputest_src,
  native : true)

test_src = files('sometest.cpp')

test_exe = executable(
  'test_exe',
  [test_src, 'cpputest_main.cpp'],
  link_whole : test_lib,
  c_args : '-include CppUTest/include/CppUTest/MemoryLeakDetectorMallocMacros.h'
  cpp_args : ['-include CppUTest/include/CppUTest/MemoryLeakDetectorMallocMacros.h',
    '-include CppUTest/include/CppUTest/MemoryLeakDetectorNewMacros.h'],
  override_options : ['b_asneeded=false', 'b_lundef=false'],
  #dependencies : [cpputest_dep, cpputestext_dep]
  include_directories : cpputest_inc,
  native : true)

# make the test executable visible to the build system test framework
test('Unit tests', test_exe)
