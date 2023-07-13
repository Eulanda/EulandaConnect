Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-IniBool' {
    BeforeAll {
        $ini = @{
            PESTERTEST = @{
                TrueBool = 'true'
                TrueOne = '1'
                TrueDollarBool = '$TRUE'
                FalseBool = 'false'
                FalseZero = '0'
                FalseDollarBool = '$FALSE'
            }
        }


        $global:ini = $ini
    }

    AfterAll {
        Remove-Variable -Name 'ini' -Scope Global
    }

    It 'returns true for TrueBool' {
        $result = Get-IniBool -section 'PESTERTEST' -variable 'TrueBool'
        $result | Should -BeTrue
    }

    It 'returns true for TrueOne' {
        $result = Get-IniBool -section 'PESTERTEST' -variable 'TrueOne'
        $result | Should -BeTrue
    }

    It 'returns true for TrueDollarBool' {
        $result = Get-IniBool -section 'PESTERTEST' -variable 'TrueDollarBool'
        $result | Should -BeTrue
    }

    It 'returns false for FalseBool' {
        $result = Get-IniBool -section 'PESTERTEST' -variable 'FalseBool'
        $result | Should -BeFalse
    }

    It 'returns false for FalseZero' {
        $result = Get-IniBool -section 'PESTERTEST' -variable 'FalseZero'
        $result | Should -BeFalse
    }

    It 'returns false for FalseDollarBool' {
        $result = Get-IniBool -section 'PESTERTEST' -variable 'FalseDollarBool'
        $result | Should -BeFalse
    }

    It 'throws when section is missing' {
        { Get-IniBool -variable 'variable' } | Should -Throw
    }

    It 'throws when variable is missing' {
        { Get-IniBool -section 'section' } | Should -Throw
    }

}
