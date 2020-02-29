#!/bin/sh


archs=(x86_64)
libraries=(*.a)
libtool="/usr/bin/libtool"

echo "Combining ${libraries[*]}..."

for library in ${libraries[*]}
do
    lipo -info $library
    # to make it fat if it isn't already.
    lipo -create $library -o $library
    # Extract individual architectures for this library
    for arch in ${archs[*]}
    do
            lipo -extract $arch $library -o ${library}_${arch}.a
    done
done

# Combine results of the same architecture into a library for that architecture
source_combined=""
for arch in ${archs[*]}
do
    source_libraries=""
    
    for library in ${libraries[*]}
    do
        source_libraries="${source_libraries} ${library}_${arch}.a"
    done
    
    $libtool -static ${source_libraries} -o "${1}_${arch}.a"
    source_combined="${source_combined} ${1}_${arch}.a"
    
    # Delete intermediate files
    rm ${source_libraries}
done

# Merge the combined library for each architecture into a single fat binary
lipo -create $source_combined -o $1.a

# Delete intermediate files
rm ${source_combined}

# Show info on the output library as confirmation
echo "Combination complete."
lipo -info $1.a