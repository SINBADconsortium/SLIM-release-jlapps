#!/bin/bash --norc

# test SLIM_COMP
if [ -n "$SLIM_COMP" ]; then
	echo SLIM_COMP = $SLIM_COMP
	test -e $SLIM_COMP/ibin/test_env4slim.sh || echo WARNING: cannot find valid $SLIM_COMP
else
	echo FATAL ERROR: undefined environment SLIM_COMP || exit 1
fi

# test SLIM_JLAPPS
if [ -n "$SLIM_JLAPPS" ]; then
	echo SLIM_JLAPPS = $SLIM_JLAPPS
	test -e $SLIM_JLAPPS/ibin/test_jl_env4slim.sh || echo WARNING: cannot find myself in SLIM_JLAPPS
else
	echo FATAL ERROR: undefined environment SLIM_JLAPPS
fi

# test SLIM_JLAPPS_RUNS
if [ -n "$SLIM_JLAPPS_RUNS" ]; then
	echo SLIM_JLAPPS_RUNS = $SLIM_JLAPPS_RUNS
	test -e $SLIM_JLAPPS_RUNS/ibin/test_jl_env4slim.sh || echo WARNING: cannot find myself in SLIM_JLAPPS_RUNS
else
	echo FATAL ERROR: undefined environment SLIM_JLAPPS_RUNS
fi

# test for julia
which julia &>/dev/null || echo ERROR: no julia executable found

# show JULIA version
echo Checking Python/JULIA version
python_version --version
julia_version --version
