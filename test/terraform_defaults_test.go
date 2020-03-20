package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
	"time"
)

func TestTerraformDefaults(t *testing.T) {
	t.Parallel()

	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/defaults")
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: exampleFolder,
		Vars: map[string]interface{}{
			"aws_region": awsRegion,
		},
	}

	terraformOptionsDiff := &terraform.Options{
		TerraformDir: exampleFolder,
		Vars: map[string]interface{}{
			"aws_region": awsRegion,
			"diff":       "stuffntings",
		},
	}

	defer test_structure.RunTestStage(t, "teardown", func() {
		terraform.Destroy(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "setup", func() {
		terraform.InitAndApply(t, terraformOptions)
		err := testImmutablity(t, terraformOptions)
		if err != nil {
			t.Fatal(err)
		}
		err = testMutablity(t, terraformOptionsDiff)
		if err != nil {
			t.Fatal(err)
		}
	})
}

func testImmutablity(t *testing.T, terraformOptions *terraform.Options) error {
	timeStart := time.Now()
	terraform.InitAndApply(t, terraformOptions)
	timeStop := time.Now()

	timeDiff := -timeStart.Sub(timeStop).Seconds()

	// Check that it doesn't run twice
	if timeDiff >= float64(5) {
		return fmt.Errorf("took %f seconds on second run with no diff between runs so it should not have run at all", timeDiff)
	} else {
		return nil
	}
}

func testMutablity(t *testing.T, terraformOptions *terraform.Options) error {
	timeStart := time.Now()
	terraform.InitAndApply(t, terraformOptions)
	timeStop := time.Now()

	timeDiff := -timeStart.Sub(timeStop).Seconds()

	// Check that it does run twice
	if timeDiff >= float64(5) {
		return nil
	} else {
		return fmt.Errorf("took less than %f seconds on second run with diff between runs so it should have run", timeDiff)
	}
}
