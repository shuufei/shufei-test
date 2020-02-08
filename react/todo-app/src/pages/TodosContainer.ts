import { connect } from 'react-redux';
import { Action, Dispatch } from 'redux';

import { RootState } from '../redux/reducers/index';
import Todos, { Props } from './Todos';

const mapStateToProps: (s: RootState) => Pick<Props, 'doneTasks' | 'unDoneTasks'> = (state) => {
  return {
    doneTasks: state.todos.todos.filter(v => v.completed),
    unDoneTasks: state.todos.todos.filter(v => !v.completed)
  };
};

const mapDispatchToProps: (d: Dispatch<Action>) => {} = (dispatch: Dispatch<Action>) => {
  return {
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Todos);
