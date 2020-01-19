function Get-PSBoundParameters {
    [cmdletbinding()]
    param(
        [Parameter(

        )]
        [string]
        $ParamOne,

        [Parameter(

        )]
        [string]
        $ParamTwo
    )

    begin {

    }

    process {
        
    }

    end {

        Invoke-PSBoundParametersAction @PSBoundParameters

    }
}

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

#test splatting
Get-PSBoundParameters -ParamOne 'value'