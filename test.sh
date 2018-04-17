#!/usr/bin/env bash
ANIMAL_NAMES=$(curl -s -X GET -H "Content-Type: application/json" localhost:5000/animals | jq '.names[]')
PEOPLE_NAMES=$(curl -s -X GET -H "Content-Type: application/json" localhost:5000/people | jq '.names[]')
RESULT=$((0))

# The animals list includes Giraffe, Lion, and Mouse
function testAnimalNames(){
    case "${ANIMAL_NAMES[@]}" in  *"Giraffe"*) RESULT=$(($RESULT+1)) ;; esac
    case "${ANIMAL_NAMES[@]}" in  *"Lion"*) RESULT=$(($RESULT+1)) ;; esac
    case "${ANIMAL_NAMES[@]}" in  *"Mouse"*) RESULT=$(($RESULT+1)) ;; esac

    if [ $RESULT -eq 3 ] 
    then
        echo "test passed"
    else
        echo "test failed"
    fi

}

# The people list contains no names longer than ten characters
function testNameLength(){
    PEOPLE_LENGTH=$(curl -s -X GET -H "Content-Type: application/json" localhost:5000/people | jq '.names | length')
    NAMES_LENGTH=$(curl -s -X GET -H "Content-Type: application/json" localhost:5000/people | jq '.names[] | length')
    RESULT=$((PEOPLE_LENGTH))

    for name in ${NAMES_LENGTH[*]} 
    do
        if [ $name -gt 10 ]
        then 
            RESULT=$(($RESULT-1))
        fi
    done

    if [ $PEOPLE_LENGTH -eq $RESULT ] 
    then 
        echo "test passed"
    else
        echo "test failed"
    fi
}

# There exists a person whose name is the same as the name of an animal
function testSameName(){
    for personName in ${PEOPLE_NAMES[@]} 
    do
        case "${ANIMAL_NAMES[@]}" in  *"${personName}"*) 
            RESULT=$(($RESULT+1)) ;; 
        esac
    done

    if [ $RESULT -gt 0 ] 
    then 
        echo "test passed"
    else
        echo "test failed"
    fi
}

echo "starting tests"

testAnimalNames
testNameLength
testSameName