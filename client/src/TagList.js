import React from 'react';
import { Icon, Label} from 'semantic-ui-react';

const Tag = () => (
  <Label className="tag" >
    tag
  </Label>
)

class TagList extends React.Component {

  render() {
    return (
      <section id="tag-list">
        <Tag/>
        <Tag/>
        <Tag/>
      </section>
    )
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default TagList;
