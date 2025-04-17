// Code generated by MockGen. DO NOT EDIT.
// Source: pkg/api/v2/processor.go

// Package mock is a generated GoMock package.
package mock

import (
	context "context"
	reflect "reflect"

	gomock "github.com/golang/mock/gomock"
	v2 "github.com/pingcap/tiflow/cdc/api/v2"
	v20 "github.com/pingcap/tiflow/pkg/api/v2"
)

// MockProcessorsGetter is a mock of ProcessorsGetter interface.
type MockProcessorsGetter struct {
	ctrl     *gomock.Controller
	recorder *MockProcessorsGetterMockRecorder
}

// MockProcessorsGetterMockRecorder is the mock recorder for MockProcessorsGetter.
type MockProcessorsGetterMockRecorder struct {
	mock *MockProcessorsGetter
}

// NewMockProcessorsGetter creates a new mock instance.
func NewMockProcessorsGetter(ctrl *gomock.Controller) *MockProcessorsGetter {
	mock := &MockProcessorsGetter{ctrl: ctrl}
	mock.recorder = &MockProcessorsGetterMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockProcessorsGetter) EXPECT() *MockProcessorsGetterMockRecorder {
	return m.recorder
}

// Processors mocks base method.
func (m *MockProcessorsGetter) Processors() v20.ProcessorInterface {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "Processors")
	ret0, _ := ret[0].(v20.ProcessorInterface)
	return ret0
}

// Processors indicates an expected call of Processors.
func (mr *MockProcessorsGetterMockRecorder) Processors() *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "Processors", reflect.TypeOf((*MockProcessorsGetter)(nil).Processors))
}

// MockProcessorInterface is a mock of ProcessorInterface interface.
type MockProcessorInterface struct {
	ctrl     *gomock.Controller
	recorder *MockProcessorInterfaceMockRecorder
}

// MockProcessorInterfaceMockRecorder is the mock recorder for MockProcessorInterface.
type MockProcessorInterfaceMockRecorder struct {
	mock *MockProcessorInterface
}

// NewMockProcessorInterface creates a new mock instance.
func NewMockProcessorInterface(ctrl *gomock.Controller) *MockProcessorInterface {
	mock := &MockProcessorInterface{ctrl: ctrl}
	mock.recorder = &MockProcessorInterfaceMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockProcessorInterface) EXPECT() *MockProcessorInterfaceMockRecorder {
	return m.recorder
}

// Get mocks base method.
func (m *MockProcessorInterface) Get(ctx context.Context, namespace, changefeedID, captureID string) (*v2.ProcessorDetail, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "Get", ctx, namespace, changefeedID, captureID)
	ret0, _ := ret[0].(*v2.ProcessorDetail)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// Get indicates an expected call of Get.
func (mr *MockProcessorInterfaceMockRecorder) Get(ctx, namespace, changefeedID, captureID interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "Get", reflect.TypeOf((*MockProcessorInterface)(nil).Get), ctx, namespace, changefeedID, captureID)
}

// List mocks base method.
func (m *MockProcessorInterface) List(ctx context.Context) ([]v2.ProcessorCommonInfo, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "List", ctx)
	ret0, _ := ret[0].([]v2.ProcessorCommonInfo)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// List indicates an expected call of List.
func (mr *MockProcessorInterfaceMockRecorder) List(ctx interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "List", reflect.TypeOf((*MockProcessorInterface)(nil).List), ctx)
}
