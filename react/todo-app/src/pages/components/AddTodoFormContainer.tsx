import { connect } from 'react-redux';
import { Action, Dispatch } from 'redux';

import { actionCreator } from '../../redux/reducers/index';
import AddTodoForm, { Props } from './AddTodoForm';

const mapStateToProps = () => {
  return {};
};

const mapDispatchToProps: (d: Dispatch<Action>) => Props = (dispatch: Dispatch<Action>) => {
  return {
    onSubmit: (text: string) => {
      dispatch(actionCreator.todos.addTodo({text}))
    }
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(AddTodoForm);
