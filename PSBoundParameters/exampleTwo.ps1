function Invoke-PSBoundParametersAction {
    [cmdletbinding()]
    param(
        [Parameter(

        )]
        [string]
        $ParamOne,

        [Parameter(

        )]
        [string]
        $ParamTwo,

        [Parameter(

        )]
        [string]
        $ParamThree
    )

    begin {

        #setup our return object
        $result = [PSCustomObject]@{

            SuccessOne = $false
            SuccessTwo = $false

        }        
    }

    process {

        #use a switch statement to take actions based on passed in parameters
        switch ($PSBoundParameters.Keys) {

            'ParamOne' {

                #perform actions if ParamOne is used
                $result.SuccessOne = $true
                
            }

            'ParamTwo' {

                #perform logic if ParamTwo is used
                $result.SuccessTwo = $true

            }

            Default {
                
                Write-Warning "Unhandled parameter -> [$($_)]"

            }
        }        
    }

    end {

        return $result

    }
}

#test with no params
Invoke-PSBoundParametersAction 

#test with ParamOne
Invoke-PSBoundParametersAction -ParamOne 'value'

#test with ParamTwo
Invoke-PSBoundParametersAction -ParamTwo 'value'

#test with ParamOne and ParamTwo
Invoke-PSBoundParametersAction -ParamOne 'value' -ParamTwo 'value'

#test with ParamThree
Invoke-PSBoundParametersAction -ParamThree 'value'

#test with ParamOne, ParamTwo, and ParamThree
Invoke-PSBoundParametersAction -ParamOne 'value' -ParamTwo 'value' -ParamThree 'value'