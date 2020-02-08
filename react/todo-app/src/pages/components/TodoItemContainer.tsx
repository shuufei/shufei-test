import { connect } from 'react-redux';
import { Action, Dispatch } from 'redux';

import { actionCreator } from '../../redux/reducers/index';
import TodoItem, { Props } from './TodoItem';

const mapStateToProps = () => {
  return {};
};

const mapDispatchToProps: (d: Dispatch<Action>) => Pick<Props, 'onToggle'> = (dispatch: Dispatch<Action>) => {
  return {
    onToggle: (id) => {
      dispatch(actionCreator.todos.toggleTodo({id}));
    }
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoItem);
