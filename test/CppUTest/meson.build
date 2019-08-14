cpputest_inc = include_directories('include', is_system : true)

cpputest_src = files(
  'src/CppUTest/CommandLineArguments.cpp',
  'src/CppUTest/MemoryLeakWarningPlugin.cpp',
  'src/CppUTest/TestHarness_c.cpp',
  'src/CppUTest/TestRegistry.cpp',
  'src/CppUTest/CommandLineTestRunner.cpp',
  'src/CppUTest/SimpleString.cpp',
  'src/CppUTest/TestMemoryAllocator.cpp',
  'src/CppUTest/TestResult.cpp',
  'src/CppUTest/JUnitTestOutput.cpp',
  'src/CppUTest/TeamCityTestOutput.cpp',
  'src/CppUTest/TestFailure.cpp',
  'src/CppUTest/TestOutput.cpp',
  'src/CppUTest/MemoryLeakDetector.cpp',
  'src/CppUTest/TestFilter.cpp',
  'src/CppUTest/TestPlugin.cpp',
  'src/CppUTest/TestTestingFixture.cpp',
  'src/CppUTest/SimpleMutex.cpp',
  'src/CppUTest/Utest.cpp'
)

cpputestext_src = files(
  'src/CppUTestExt/CodeMemoryReportFormatter.cpp',
  'src/CppUTestExt/IEEE754ExceptionsPlugin.cpp',
  'src/CppUTestExt/MemoryReporterPlugin.cpp',
  'src/CppUTestExt/MockFailure.cpp',
  'src/CppUTestExt/MockSupportPlugin.cpp',
  'src/CppUTestExt/MockActualCall.cpp',
  'src/CppUTestExt/MockSupport_c.cpp',
  'src/CppUTestExt/MemoryReportAllocator.cpp',
  'src/CppUTestExt/MockExpectedCall.cpp',
  'src/CppUTestExt/MockNamedValue.cpp',
  'src/CppUTestExt/OrderedTest.cpp',
  'src/CppUTestExt/MemoryReportFormatter.cpp',
  'src/CppUTestExt/MockExpectedCallsList.cpp',
  'src/CppUTestExt/MockSupport.cpp'
)

platform_src = files('src/Platforms/Gcc/UtestPlatform.cpp')

memoryleak = files(
  'include/CppUTest/MemoryLeakDetectorNewMacros.h',
  'include/CppUTest/MemoryLeakDetectorMallocMacros.h'
)

memleak_arg = []
# parse memleak files
foreach memleak : memoryleak
  memleak_arg += ['-include @0@/@1@'.format(meson.source_root(), memleak)]
endforeach

# build the libraries
cpputest_lib = static_library('cpputest_lib',
  [cpputest_src, platform_src],
  include_directories : cpputest_inc,
  native : true)

cpputestext_lib = static_library('cpputestext_lib',
  [cpputestext_src, platform_src],
  include_directories : cpputest_inc,
  native : true)

# dependency to use when making test executable
cpputest_dep = declare_dependency(
  link_with : [cpputest_lib, cpputestext_lib],
  include_directories : cpputest_inc)
